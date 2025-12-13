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
      //         id: Value(5),
      //         address: Value('улица Борисова, 24'),
      //         number: Value(5),
      //         name: Value('Общежитие 5'),
      //         long: Value(92.796050),
      //         lat: Value(55.994265),
      //       ),
      //     );

      // dependency.database
      //     .into(dependency.database.rooms)
      //     .insert(
      //       RoomsCompanion(
      //         id: Value(1),
      //         dormitoryId: Value(5),
      //         floor: Value(6),
      //         number: Value('6-42'),
      //         isOccupied: Value(true),
      //       ),
      //     );

      final protectedRoutes = Pipeline()
          .addMiddleware(corsHeaders())
          .addMiddleware(
            AuthenticationMiddleware.call(
              firebaseAdmin: dependency.firebaseAdmin,
            ),
          )
          .addHandler(
            Cascade()
                .add(dependency.profileRouter.handler)
                .add(dependency.userRouter.protectedHandler)
                .add(dependency.studentRouter.handler)
                .add(dependency.dormitoryRouter.handler)
                .add(dependency.specializationRouter.handler)
                .add(dependency.roomRouter.handler)
                .add(dependency.requestRouter.handler)
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
