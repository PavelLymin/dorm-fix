import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/logic/composition_root.dart';
import 'package:backend/src/server/middleware/authentication.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

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

      Cascade cascade = Cascade()
          .add(dependency.studentRouter.handler)
          .add(dependency.dormitoryRouter.handler)
          .add(dependency.specializationRouter.handler);

      final handler = Pipeline()
          .addMiddleware(logRequests())
          .addMiddleware(
            AuthenticationMiddleware.check(
              firebaseAdmin: dependency.firebaseAdmin,
            ),
          )
          .addHandler(cascade.handler);

      final port = int.parse(dependency.config.port);
      await serve(handler, ip, port);
    },
    (e, stackTrace) {
      logger.e(e.toString(), stackTrace: stackTrace);
    },
  );
}
