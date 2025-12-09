import 'dart:io';

import 'package:backend/src/server/router/room.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:logger/web.dart';
import '../../core/database/database.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../../server/data/repository/dormitory_repository.dart';
import '../../server/data/repository/master_repository.dart';
import '../../server/data/repository/room_repository.dart';
import '../../server/data/repository/specialization_repository.dart';
import '../../server/data/repository/student_repository.dart';
import '../../server/data/repository/user_repository.dart';
import '../../server/router/dormitory.dart';
import '../../server/router/profile.dart';
import '../../server/router/specialization.dart';
import '../../server/router/student.dart';
import '../../server/router/user.dart';
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

    final restApi = RestApiBase();

    // User
    final userRepository = UserRepositoryImpl(database: database);
    final userRouter = UserRouter(
      userRepository: userRepository,
      restApi: restApi,
    );

    // Student
    final studentRepository = StudentRepositoryImpl(
      database: database,
      firebaseAdmin: app,
    );
    final studentRouter = StudentRouter(
      studentRepository: studentRepository,
      restApi: restApi,
    );

    // Master
    final masterRepository = MasterRepository(database: database);

    // Profile
    final profileRouter = ProfileRouter(
      restApi: restApi,
      studentRepository: studentRepository,
      masterRepository: masterRepository,
    );

    // Dormitory
    final dormitoryRepository = DormitoryRepository(database: database);
    final dormitoryRouter = DormitoryRouter(
      dormitoryRepository: dormitoryRepository,
      restApi: restApi,
    );

    // Room
    final roomRepository = RoomRepository(database: database);
    final roomRouter = RoomRouter(
      roomRepository: roomRepository,
      restApi: restApi,
    );

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      database: database,
    );
    final specializationRouter = SpecializationRouter(
      specializationRepository: specializationRepository,
      restApi: restApi,
    );

    return _DependencyFactory(
      firebaseAdmin: app,
      config: config,
      restApi: restApi,
      database: database,
      userRouter: userRouter,
      profileRouter: profileRouter,
      studentRouter: studentRouter,
      dormitoryRouter: dormitoryRouter,
      roomRouter: roomRouter,
      specializationRouter: specializationRouter,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAdmin,
    required this.config,
    required this.restApi,
    required this.database,
    required this.userRouter,
    required this.profileRouter,
    required this.studentRouter,
    required this.dormitoryRouter,
    required this.roomRouter,
    required this.specializationRouter,
  });

  final App firebaseAdmin;

  final Config config;

  final RestApi restApi;

  final Database database;

  final UserRouter userRouter;

  final ProfileRouter profileRouter;

  final StudentRouter studentRouter;

  final DormitoryRouter dormitoryRouter;

  final RoomRouter roomRouter;

  final SpecializationRouter specializationRouter;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAdmin: firebaseAdmin,
    config: config,
    restApi: restApi,
    database: database,
    userRouter: userRouter,
    profileRouter: profileRouter,
    studentRouter: studentRouter,
    dormitoryRouter: dormitoryRouter,
    roomRouter: roomRouter,
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
