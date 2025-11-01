import 'dart:io';

import 'package:backend/src/app/model/application_config.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:logger/web.dart';
import '../../core/database/database.dart';
import '../../server/data/repository/dormitory_repository.dart';
import '../../server/data/repository/student_repository.dart';
import '../../server/router/building.dart';
import '../../server/router/student.dart';
import '../model/dependencies_container.dart';

abstract class Factory<T> {
  const Factory();

  T create();
}

abstract class AsyncFactory<T> {
  const AsyncFactory();

  Future<T> create();
}

class CompositionRoot {
  const CompositionRoot({required this.logger});

  final Logger logger;

  Future<DependencyContainer> compose() async {
    logger.i('Initializing dependencies...');

    // Config
    final config = Config();

    // Firebase
    final options = AppOptions(
      credential: FirebaseAdmin.instance.certFromPath(config.serviceAccount),
    );

    final app = FirebaseAdmin.instance.initializeApp(options);

    // Database
    final database = Database.lazy(file: File(config.databasePath));

    // Student
    final studentRepository = StudentRepositoryImpl();
    final studentRouter = StudentRouter(studentRepository: studentRepository);

    // Building
    final buildingRepository = BuildingRepositoryImpl(database: database);
    final buildingRouter = BuildingRouter(
      buildingRepository: buildingRepository,
    );

    return _DependencyFactory(
      firebaseAdmin: app,
      config: config,
      database: database,
      studentRouter: studentRouter,
      buildingRouter: buildingRouter,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAdmin,
    required this.config,
    required this.database,
    required this.studentRouter,
    required this.buildingRouter,
  });

  final App firebaseAdmin;

  final Config config;

  final Database database;

  final StudentRouter studentRouter;

  final BuildingRouter buildingRouter;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAdmin: firebaseAdmin,
    config: config,
    database: database,
    studentRouter: studentRouter,
    buildingRouter: buildingRouter,
  );
}

class CreateAppLogger extends Factory<Logger> {
  const CreateAppLogger();

  @override
  Logger create() {
    final logger = Logger(printer: PrettyPrinter(colors: false));
    return logger;
  }
}
