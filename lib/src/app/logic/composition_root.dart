import 'package:dorm_fix/firebase_options.dart';
import 'package:dorm_fix/src/app/model/application_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/authentication/data/repository/user_repository.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/data/repository/specialization_repository.dart';
import '../../features/home/state_management/bloc/specialization_bloc.dart';
import '../../features/profile/student/data/repository/student_repository.dart';
import '../../features/profile/student/state_management/bloc/student_bloc.dart';
import '../../features/yandex_map/data/repositories/search_repository.dart';
import '../../features/yandex_map/state_management/bloc/search_bloc.dart';
import '../model/dependencies.dart';

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

    // Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Mapkit
    final mapkitApiKey = Config.mapKitApiKey;
    await init.initMapkit(apiKey: mapkitApiKey);

    // Http
    final RestClientHttp client = RestClientHttp(
      baseUrl: Config.apiBaseUrl,
      client: createDefaultHttpClient(),
    );

    // Firebase
    final firebaseAuth = await _CreateFirebaseAuth().create();

    final userPerository = UserRepositoryImpl(client: client);

    // Authentication
    final authRepository = AuthRepository(firebaseAuth: firebaseAuth);
    final authenticationBloc = AuthBloc(
      authRepository: authRepository,
      userRepository: userPerository,
      logger: logger,
    );
    final authButton = AuthButtonBloc();

    // Student
    final studentRepository = StudentRepositoryImpl(client: client);
    final studentBloc = StudentBloc(
      studentRepository: studentRepository,
      logger: logger,
    );

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      client: client,
    );
    final specializationBloc = SpecializationBloc(
      specializationRepository: specializationRepository,
      logger: logger,
    );

    // Search Dormitory
    final searchRepository = SearchRepository(client: client);
    final searchBloc = SearchBloc(searchRepository: searchRepository);

    return _DependencyFactory(
      client: client,
      authenticationBloc: authenticationBloc,
      authButton: authButton,
      studentBloc: studentBloc,
      specializationBloc: specializationBloc,
      searchBloc: searchBloc,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.client,
    required this.authenticationBloc,
    required this.authButton,
    required this.studentBloc,
    required this.specializationBloc,
    required this.searchBloc,
  });

  final RestClientHttp client;

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;

  final StudentBloc studentBloc;

  final SpecializationBloc specializationBloc;

  final SearchBloc searchBloc;

  @override
  DependencyContainer create() => DependencyContainer(
    client: client,
    authenticationBloc: authenticationBloc,
    authButton: authButton,
    studentBloc: studentBloc,
    specializationBloc: specializationBloc,
    searchBloc: searchBloc,
  );
}

class _CreateFirebaseAuth extends AsyncFactory<FirebaseAuth> {
  const _CreateFirebaseAuth();

  @override
  Future<FirebaseAuth> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return FirebaseAuth.instance;
  }
}

class CreateAppLogger extends Factory<Logger> {
  const CreateAppLogger();

  @override
  Logger create() {
    final logger = Logger(printer: PrettyPrinter(colors: false));
    return logger;
  }
}
