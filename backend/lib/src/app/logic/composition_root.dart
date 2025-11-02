import 'dart:io';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:logger/web.dart';
import '../../core/database/database.dart';
import '../../server/data/repository/dormitory_repository.dart';
import '../../server/data/repository/specialization_repository.dart';
import '../../server/data/repository/student_repository.dart';
import '../../server/router/dormitory.dart';
import '../../server/router/specialization.dart';
import '../../server/router/student.dart';
import '../model/application_config.dart';
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
    final studentRepository = StudentRepositoryImpl(database: database);
    final studentRouter = StudentRouter(studentRepository: studentRepository);

    // Dormitory
    final dormitoryRepository = DormitoryRepositoryImpl(database: database);
    final dormitoryRouter = DormitoryRouter(
      dormitoryRepository: dormitoryRepository,
    );

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      database: database,
    );
    final specializationRouter = SpecializationRouter(
      specializationRepository: specializationRepository,
    );

    return _DependencyFactory(
      firebaseAdmin: app,
      config: config,
      database: database,
      studentRouter: studentRouter,
      dormitoryRouter: dormitoryRouter,
      specializationRouter: specializationRouter,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAdmin,
    required this.config,
    required this.database,
    required this.studentRouter,
    required this.dormitoryRouter,
    required this.specializationRouter,
  });

  final App firebaseAdmin;

  final Config config;

  final Database database;

  final StudentRouter studentRouter;

  final DormitoryRouter dormitoryRouter;

  final SpecializationRouter specializationRouter;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAdmin: firebaseAdmin,
    config: config,
    database: database,
    studentRouter: studentRouter,
    dormitoryRouter: dormitoryRouter,
    specializationRouter: specializationRouter,
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
