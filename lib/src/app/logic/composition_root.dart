import 'package:dorm_fix/src/features/repair_request/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../firebase_options.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/ws/ws.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/room/room.dart';
import '../../features/settings/settings.dart';
import '../../features/yandex_mapkit/yandex_mapkit.dart';
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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Http
    final RestClientHttp client = RestClientHttp(
      baseUrl: Config.apiBaseUrl,
      client: createDefaultHttpClient(),
    );

    final IWebSocket webSocket = WebSocketBase(
      uri: '${Config.wsBaseUrl}/connection',
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

    final googleSignIn = GoogleSignIn.instance;
    // await googleSignIn.initialize(clientId: Config.googleClientId);

    // Authentication
    final authRepository = AuthRepository(
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
      webSocket: webSocket,
    );
    final authenticationBloc = AuthBloc(
      authRepository: authRepository,
      userRepository: userPerository,
      firebaseUserRepository: firebaseUserRepository,
      logger: logger,
    );

    // auto_route
    final router = AppRouter(authenticationBloc: authenticationBloc);

    // Settings
    final settingsContainer = await _CreateSettings().create();

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

    final specializationBloc = SpecializationBloc(
      specializationRepository: specializationRepository,
      logger: logger,
    );

    // Search Dormitory
    final dormitoryRepository = DormitoryRepository(
      client: client,
      firebaseAuth: firebaseAuth,
    );
    final dormitorySearchBloc = DormitorySearchBloc(
      dormitoryRepository: dormitoryRepository,
      logger: logger,
    );

    // Room
    final roomRepository = RoomRepository(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // RepairRequest
    final requestRepository = RequestRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    final repairRequestBloc = RepairRequestBloc(
      requestRepository: requestRepository,
      webSocket: webSocket,
      logger: logger,
    );

    return _DependencyFactory(
      firebaseAuth: firebaseAuth,
      client: client,
      webSocket: webSocket,
      router: router,
      dormitorySearchBloc: dormitorySearchBloc,
      logger: logger,
      settingsContainer: settingsContainer,
      authenticationBloc: authenticationBloc,
      profileBloc: profileBloc,
      userRepository: userRepository,
      studentRepository: studentRepository,
      firebaseUserRepository: firebaseUserRepository,
      specializationBloc: specializationBloc,
      dormitoryRepository: dormitoryRepository,
      roomRepository: roomRepository,
      requestRepository: requestRepository,
      repairRequestBloc: repairRequestBloc,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAuth,
    required this.client,
    required this.webSocket,
    required this.router,
    required this.logger,
    required this.settingsContainer,
    required this.authenticationBloc,
    required this.profileBloc,
    required this.userRepository,
    required this.studentRepository,
    required this.firebaseUserRepository,
    required this.specializationBloc,
    required this.dormitorySearchBloc,
    required this.roomRepository,
    required this.dormitoryRepository,
    required this.requestRepository,
    required this.repairRequestBloc,
  });

  final FirebaseAuth firebaseAuth;

  final RestClientHttp client;

  final IWebSocket webSocket;

  final AppRouter router;

  final Logger logger;

  final SettingsContainer settingsContainer;

  final AuthBloc authenticationBloc;

  final ProfileBloc profileBloc;

  final IUserRepository userRepository;

  final IStudentRepository studentRepository;

  final IFirebaseUserRepository firebaseUserRepository;

  final DormitorySearchBloc dormitorySearchBloc;

  final RoomRepository roomRepository;

  final IDormitoryRepository dormitoryRepository;

  final SpecializationBloc specializationBloc;

  final RepairRequestBloc repairRequestBloc;

  final IRequestRepository requestRepository;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAuth: firebaseAuth,
    client: client,
    webSocket: webSocket,
    router: router,
    logger: logger,
    settingsContainer: settingsContainer,
    authenticationBloc: authenticationBloc,
    profileBloc: profileBloc,
    userRepository: userRepository,
    studentRepository: studentRepository,
    firebaseUserRepository: firebaseUserRepository,
    dormitorySearchBloc: dormitorySearchBloc,
    roomRepository: roomRepository,
    dormitoryRepository: dormitoryRepository,
    specializationBloc: specializationBloc,
    requestRepository: requestRepository,
    repairRequestBloc: repairRequestBloc,
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
