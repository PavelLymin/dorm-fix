import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/logic/composition_root.dart';
import 'package:backend/src/server/middleware/authentication.dart';
import 'package:backend/src/server/middleware/error.dart';
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

      // dependency.database
      //     .into(dependency.database.dormitories)
      //     .insert(
      //       DormitoriesCompanion(
      //         address: Value('проспект Свободный, 76Н'),
      //         number: Value(21),
      //         name: Value('общежитие 21'),
      //         long: Value(92.766513),
      //         lat: Value(56.008465),
      //       ),
      //     );

      final protectedRoutes = Pipeline()
          .addMiddleware(corsHeaders())
          // .addMiddleware(
          //   AuthenticationMiddleware.call(
          //     firebaseAdmin: dependency.firebaseAdmin,
          //   ),
          // )
          .addHandler(
            Cascade()
                .add(dependency.profileRouter.handler)
                .add(dependency.userRouter.protectedHandler)
                .add(dependency.studentRouter.handler)
                .add(dependency.dormitoryRouter.handler)
                .add(dependency.specializationRouter.handler)
                .add(dependency.roomRouter.handler)
                .handler,
          );

      final handlers = Pipeline()
          .addMiddleware(logRequests())
          .addMiddleware(ErrorMiddleware.call(logger, dependency.restApi))
          .addHandler(Cascade().add(publicRoutes).add(protectedRoutes).handler);

      final port = int.parse(dependency.config.port);
      await serve(handlers, ip, port);
    },
    (e, stackTrace) {
      logger.e(e.toString(), stackTrace: stackTrace);
    },
  );
}
