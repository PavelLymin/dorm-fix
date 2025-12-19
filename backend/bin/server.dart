import 'dart:async';
import 'dart:io';

import 'package:backend/src/app/logic/composition_root.dart';
import 'package:backend/src/core/database/database.dart';
import 'package:backend/src/core/middleware/authentication.dart';
import 'package:backend/src/core/middleware/error.dart';
import 'package:backend/src/server/data/repository/student_repository.dart';
import 'package:backend/src/server/model/student.dart';
import 'package:backend/src/server/model/user.dart';
import 'package:drift/drift.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main(List<String> args) async {
  final logger = CreateAppLogger().create();

  await runZonedGuarded(
    () async {
      final dependency = await CompositionRoot(logger: logger).compose();

      final studentRepository = StudentRepositoryImpl(
        database: dependency.database,
      );

      await dependency.database
          .into(dependency.database.specializations)
          .insert(
            SpecializationsCompanion(
              title: Value('Электрик'),
              description: Value('Данный поиск осуществляется по тексту'),
              photoUrl: Value('instruments.webp'),
            ),
          );

      await dependency.database
          .into(dependency.database.specializations)
          .insert(
            SpecializationsCompanion(
              title: Value('Сантехник'),
              description: Value('Данный поиск осуществляется по тексту'),
              photoUrl: Value('sink.webp'),
            ),
          );
      await dependency.database
          .into(dependency.database.specializations)
          .insert(
            SpecializationsCompanion(
              title: Value('Слесарь'),
              description: Value('Данный поиск осуществляется по тексту'),
              photoUrl: Value('angle_grinder.webp'),
            ),
          );

      dependency.database
          .into(dependency.database.dormitories)
          .insert(
            DormitoriesCompanion(
              number: Value(30),
              name: Value('Общежитие 30'),
              address: Value('Борисова, д. 3'),
              lat: Value(55.995387),
              long: Value(92.793795),
            ),
          );

      dependency.database
          .into(dependency.database.rooms)
          .insert(
            RoomsCompanion(
              dormitoryId: Value(1),
              floor: Value(6),
              number: Value('6-42'),
              isOccupied: Value(true),
            ),
          );

      dependency.database
          .into(dependency.database.rooms)
          .insert(
            RoomsCompanion(
              dormitoryId: Value(1),
              floor: Value(6),
              number: Value('6-41'),
              isOccupied: Value(true),
            ),
          );

      dependency.database
          .into(dependency.database.rooms)
          .insert(
            RoomsCompanion(
              dormitoryId: Value(1),
              floor: Value(10),
              number: Value('10-42'),
              isOccupied: Value(true),
            ),
          );

      await studentRepository.createStudent(
        uid: 'qt5rp4zdNhdtX5YAYlpNCsmXDii2',
        student: CreatedStudentEntity(
          user: UserEntity(
            uid: 'qt5rp4zdNhdtX5YAYlpNCsmXDii2',
            displayName: 'Павел Лямин',
            email: 'pavel.lyamin2005@gmail.com',
            phoneNumber: '+79144563446',
            photoURL:
                'https://lh3.googleusercontent.com/a/ACg8ocLitU-DssP2_XkxVZD_FkKiK7DRYErs3Fi_pukOltdrN3zlTQ=s96-c',
            role: .student,
          ),
          roomId: 1,
          dormitoryId: 1,
        ),
      );

      await studentRepository.createStudent(
        uid: 'Bmqey1s4b3ZrbKhEC0DrD7SMvnD2',
        student: CreatedStudentEntity(
          user: UserEntity(
            uid: 'Bmqey1s4b3ZrbKhEC0DrD7SMvnD2',
            displayName: 'Лямин Вадим',
            email: 'vadim.lyamin.05@mail.ru',
            phoneNumber: '+71234567890',
            photoURL:
                'https://lh3.googleusercontent.com/a/ACg8ocLitU-DssP2_XkxVZD_FkKiK7DRYErs3Fi_pukOltdrN3zlTQ=s96-c',
            role: .student,
          ),
          roomId: 2,
          dormitoryId: 1,
        ),
      );

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
