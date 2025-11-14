import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/logic/composition_root.dart';
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

      final publicRoutes = Pipeline()
          .addMiddleware(logRequests())
          .addHandler(
            Cascade().add(dependency.userRouter.publicHandler).handler,
          );

      final protectedRoutes = Pipeline()
          .addMiddleware(logRequests())
          .addMiddleware(corsHeaders())
          // .addMiddleware(
          //   AuthenticationMiddleware.check(
          //     firebaseAdmin: dependency.firebaseAdmin,
          //   ),
          // )
          .addHandler(
            Cascade()
                .add(dependency.userRouter.protectedHandler)
                .add(dependency.studentRouter.handler)
                .add(dependency.dormitoryRouter.handler)
                .add(dependency.specializationRouter.handler)
                .handler,
          );

      final handlers = Cascade().add(publicRoutes).add(protectedRoutes).handler;

      final port = int.parse(dependency.config.port);
      await serve(handlers, ip, port);
    },
    (e, stackTrace) {
      logger.e(e.toString(), stackTrace: stackTrace);
    },
  );
}
