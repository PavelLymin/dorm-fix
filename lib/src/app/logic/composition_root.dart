import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../firebase_options.dart';
import '../../core/rest_client/rest_client.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';
import '../../features/yandex_mapkit/data/repository/dormitory_repository.dart';
import '../../features/yandex_mapkit/state_management/pins/bloc/pins_bloc.dart';
import '../../features/yandex_mapkit/state_management/search/search_bloc.dart';
import '../bloc/app_bloc_observer.dart';
import '../model/application_config.dart';
import '../model/dependencies.dart';
import '../router/router.dart';

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
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    // auto_route
    final router = AppRouter();

    // Settings
    final settingsContainer = await _CreateSettings().create();

    // Http
    final RestClientHttp client = RestClientHttp(
      baseUrl: Config.apiBaseUrl,
      client: createDefaultHttpClient(),
    );

    // Firebase
    final firebaseAuth = await _CreateFirebaseAuth().create();

    Bloc.observer = AppBlocObserver(logger: logger);

    // User
    final userPerository = UserRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Firebase User
    final firebaseUserRepository = FirebaseUserRepositoryImpl(
      firebaseAuth: firebaseAuth,
    );

    // Authentication
    final authRepository = AuthRepository(firebaseAuth: firebaseAuth);
    final authenticationBloc = AuthBloc(
      authRepository: authRepository,
      userRepository: userPerository,
      firebaseUserRepository: firebaseUserRepository,
      logger: logger,
    );
    final authButton = AuthButtonBloc();

    // Student
    final studentRepository = StudentRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Profile
    final profileRepository = ProfileRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );
    final profileBloc = ProfileBloc(
      logger: logger,
      profileRepository: profileRepository,
      studentRepository: studentRepository,
    );

    final userRepository = UserRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Search Dormitory
    final searchRepository = DormitoryRepository(client: client);
    final searchBloc = SearchBloc(
      dormitoryRepository: searchRepository,
      logger: logger,
    );
    final pinsBloc = PinsBloc(
      dormitoryRepository: searchRepository,
      logger: logger,
    );

    return _DependencyFactory(
      client: client,
      router: router,
      searchBloc: searchBloc,
      logger: logger,
      settingsContainer: settingsContainer,
      authenticationBloc: authenticationBloc,
      profileBloc: profileBloc,
      userRepository: userRepository,
      firebaseUserRepository: firebaseUserRepository,
      authButton: authButton,
      specializationRepository: specializationRepository,
      pinsBloc: pinsBloc,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.client,
    required this.router,
    required this.searchBloc,
    required this.logger,
    required this.settingsContainer,
    required this.authenticationBloc,
    required this.profileBloc,
    required this.userRepository,
    required this.firebaseUserRepository,
    required this.authButton,
    required this.specializationRepository,
    required this.pinsBloc,
  });

  final RestClientHttp client;

  final AppRouter router;

  final Logger logger;

  final SettingsContainer settingsContainer;

  final AuthBloc authenticationBloc;

  final ProfileBloc profileBloc;

  final IUserRepository userRepository;

  final IFirebaseUserRepository firebaseUserRepository;

  final AuthButtonBloc authButton;

  final SearchBloc searchBloc;

  final PinsBloc pinsBloc;

  final ISpecializationRepository specializationRepository;

  @override
  DependencyContainer create() => DependencyContainer(
    client: client,
    router: router,
    searchBloc: searchBloc,
    logger: logger,
    settingsContainer: settingsContainer,
    authenticationBloc: authenticationBloc,
    profileBloc: profileBloc,
    userRepository: userRepository,
    firebaseUserRepository: firebaseUserRepository,
    authButton: authButton,
    pinsBloc: pinsBloc,
    specializationRepository: specializationRepository,
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

class _CreateSettings extends AsyncFactory<SettingsContainer> {
  const _CreateSettings();

  @override
  Future<SettingsContainer> create() async {
    final sharedPreferences = SharedPreferencesAsync();
    final settingsContainer = await SettingsContainer.create(
      sharedPreferences: sharedPreferences,
    );

    return settingsContainer;
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
