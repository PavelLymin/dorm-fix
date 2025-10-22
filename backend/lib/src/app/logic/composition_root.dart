import 'package:backend/src/app/model/application_config.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:logger/web.dart';
import '../../core/database/database.dart';
import '../../server/data/repository/student_repository.dart';
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

    final config = Config();

    final options = AppOptions(
      credential: FirebaseAdmin.instance.certFromPath(
        '/Users/pavellyamin/Development/dorm_fix/backend/bin/service-account.json',
      ),
    );

    final app = FirebaseAdmin.instance.initializeApp(options);

    final database = AppDatabase(path: config.databasePath);

    final studentRepository = StudentRepositoryImpl();
    final studentRouter = StudentRouter(studentRepository: studentRepository);

    return _DependencyFactory(
      firebaseAdmin: app,
      config: config,
      database: database,
      studentRouter: studentRouter,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAdmin,
    required this.config,
    required this.database,
    required this.studentRouter,
  });

  final App firebaseAdmin;

  final Config config;

  final AppDatabase database;

  final StudentRouter studentRouter;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAdmin: firebaseAdmin,
    config: config,
    database: database,
    studentRouter: studentRouter,
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
