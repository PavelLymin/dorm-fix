import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/logic/composition_root.dart';
import 'package:backend/src/app/model/application_config.dart';
import 'package:backend/src/core/middleware/authentication.dart';
import 'package:backend/src/core/middleware/error.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main(List<String> args) async {
  final logger = CreateAppLogger().create();

  await runZonedGuarded(
    () async {
      final dependency = await CompositionRoot(logger: logger).compose();

      ProcessSignal.sigint.watch().listen((_) async {
        await dependency.database.close();
        exit(0);
      });

      final ip = InternetAddress.anyIPv4;

      final publicRoutes = Pipeline().addHandler(
        Cascade().add(dependency.userRouter.publicHandler).handler,
      );

      final protectedRoutes = Pipeline()
          .addMiddleware(corsHeaders())
          .addMiddleware(
            AuthenticationMiddleware.call(
              firebaseAdmin: dependency.firebaseAdmin,
            ),
          )
          .addHandler(
            Cascade()
                .add(dependency.wsRouter.handler)
                .add(dependency.profileRouter.handler)
                .add(dependency.userRouter.protectedHandler)
                .add(dependency.dormitoryRouter.handler)
                .add(dependency.specializationRouter.handler)
                .add(dependency.roomRouter.handler)
                .add(dependency.repairRequestRouter.handler)
                .add(dependency.chatRouter.handler)
                .add(dependency.messageRouter.handler)
                .handler,
          );

      final handlers = Pipeline()
          .addMiddleware(logRequests())
          .addMiddleware(ErrorMiddleware.call(logger, dependency.restApi))
          .addHandler(Cascade().add(publicRoutes).add(protectedRoutes).handler);

      final port = int.parse(Config.port);
      await serve(handlers, ip, port);
    },
    (e, stackTrace) {
      logger.e(e.toString(), stackTrace: stackTrace);
    },
  );
}
