import 'package:dorm_fix/firebase_options.dart';
import 'package:dorm_fix/src/app/model/application_config.dart';
import 'package:dorm_fix/src/app/router/router.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/data/repository/dormitory_repository.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/state_management/pins/bloc/pins_bloc.dart';
import 'package:dorm_fix/src/features/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/data/repository/auth_repository.dart';
import '../../features/profile/data/repository/firebase_user_repository.dart';
import '../../features/profile/data/repository/user_repository.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/data/repository/specialization_repository.dart';
import '../../features/profile/data/repository/profile_repository.dart';
import '../../features/profile/data/repository/student_repository.dart';
import '../../features/yandex_mapkit/state_management/search/search_bloc.dart';
import '../../features/profile/state_management/profile_bloc/profile_bloc.dart';
import '../bloc/app_bloc_observer.dart';
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
      userRepository: userPerository,
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
