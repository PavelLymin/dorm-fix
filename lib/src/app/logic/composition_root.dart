import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../firebase_options.dart';
import '../../core/middleware/src/authenticated_middleware.dart';
import '../../core/middleware/src/logger_middleware.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/ws/ws.dart';
import '../../features/authentication/authentication.dart';
import '../../features/chat/chat.dart';
import '../../features/dormitory/dormitory.dart';
import '../../features/instructions/instructions.dart';
import '../../features/master/master.dart';
import '../../features/material/material.dart';
import '../../features/repair_request/request.dart';
import '../../features/specialization/specialization.dart';
import '../../features/profile/profile.dart';
import '../../features/room/room.dart';
import '../../features/settings/settings.dart';
import '../../features/students/student.dart';
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

    await dotenv.load(fileName: ".env");

    // Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseAuth = await _CreateFirebaseAuth().create();

    final supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANNON_KEY']!,
    );

    // Google
    final googleSignIn = GoogleSignIn.instance;

    // WS
    final IWebSocket webSocket = WebSocketBase(
      uri: '${Config.wsBaseUrl}/connection',
    );

    // Authentication
    final authRepository = AuthRepository(
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
      webSocket: webSocket,
    );

    final client = await _CreateHttpClient(
      authRepository: authRepository,
    ).create();

    // BLoC observer
    Bloc.observer = AppBlocObserver(logger: logger);

    // Firebase User
    final firebaseUserRepository = FirebaseUserRepositoryImpl(
      firebaseAuth: firebaseAuth,
    );

    // Profile
    final profileRepository = ProfileRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // User
    final userRepository = UserRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
      supabase: supabase.client,
    );

    // Student
    final studentRepository = StudentRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Master
    final masterRepository = MasterRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Settings
    final settingsContainer = await _CreateSettings().create();

    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    //  Dormitory
    final dormitoryRepository = DormitoryRepository(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    final dormitoryBloc = DormitoryBloc(
      dormitoryRepository: dormitoryRepository,
      logger: logger,
    );

    // Room
    final roomRepository = RoomRepository(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Chat
    final chatRepository = ChatRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    final chatRealTimeRepository = ChatRealTimeRepositoryImpl(
      webSocket: webSocket,
    );

    // Message
    final messageRepository = MessageRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    final messageRealTimeRepository = MessageRealTimeRepositoryImpl(
      webSocket: webSocket,
    );

    // RepairRequest
    final requestRepository = RequestRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    final authenticationBloc = AuthBloc(
      authRepository: authRepository,
      firebaseUserRepository: firebaseUserRepository,
      profileRepository: profileRepository,
      logger: logger,
    );

    final specializationBloc = SpecializationBloc(
      specializationRepository: specializationRepository,
      logger: logger,
    );

    final problemRepository = ProblemRepositoryImpl(supabase: supabase.client);

    // Material
    final materialRepository = MaterialRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );
    final materialTypeRepository = MaterialTypeRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // Instruction
    final instructionRepository = InstructionRepositoryImpl(
      client: client,
      firebaseAuth: firebaseAuth,
    );

    // auto_route
    final router = AppRouter(authGuard: AuthGuard(authenticationBloc));

    return _DependencyFactory(
      firebaseAuth: firebaseAuth,
      client: client,
      webSocket: webSocket,
      router: router,
      logger: logger,
      settingsContainer: settingsContainer,
      authenticationBloc: authenticationBloc,
      userRepository: userRepository,
      firebaseUserRepository: firebaseUserRepository,
      specializationBloc: specializationBloc,
      dormitoryRepository: dormitoryRepository,
      roomRepository: roomRepository,
      requestRepository: requestRepository,
      chatRepository: chatRepository,
      chatRealTimeRepository: chatRealTimeRepository,
      messageRepository: messageRepository,
      messageRealTimeRepository: messageRealTimeRepository,
      problemRepository: problemRepository,
      masterRepository: masterRepository,
      studentRepository: studentRepository,
      materialRepository: materialRepository,
      instructionRepository: instructionRepository,
      materialTypeRepository: materialTypeRepository,
      dormitoryBloc: dormitoryBloc,
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
    required this.userRepository,
    required this.firebaseUserRepository,
    required this.roomRepository,
    required this.dormitoryRepository,
    required this.requestRepository,
    required this.chatRepository,
    required this.chatRealTimeRepository,
    required this.messageRepository,
    required this.messageRealTimeRepository,
    required this.problemRepository,
    required this.masterRepository,
    required this.studentRepository,
    required this.materialRepository,
    required this.materialTypeRepository,
    required this.authenticationBloc,
    required this.specializationBloc,
    required this.dormitoryBloc,
    required this.instructionRepository,
  });

  // Firebase
  final FirebaseAuth firebaseAuth;

  // RestClient
  final RestClientHttp client;

  // WebSocket
  final IWebSocket webSocket;

  // Router
  final AppRouter router;

  // Logger
  final Logger logger;

  // Settings
  final SettingsContainer settingsContainer;

  // Repositories
  final IUserRepository userRepository;
  final IFirebaseUserRepository firebaseUserRepository;
  final RoomRepository roomRepository;
  final IDormitoryRepository dormitoryRepository;
  final IRequestRepository requestRepository;
  final IChatRepository chatRepository;
  final IChatRealTimeRepository chatRealTimeRepository;
  final IMessageRepository messageRepository;
  final IMessageRealtimeRepository messageRealTimeRepository;
  final IProblemRepository problemRepository;
  final IMasterRepository masterRepository;
  final IStudentRepository studentRepository;
  final IMaterialRepository materialRepository;
  final IMaterialTypeRepository materialTypeRepository;
  final IInstructionRepository instructionRepository;

  // BloC
  final AuthBloc authenticationBloc;
  final SpecializationBloc specializationBloc;
  final DormitoryBloc dormitoryBloc;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAuth: firebaseAuth,
    client: client,
    webSocket: webSocket,
    router: router,
    logger: logger,
    settingsContainer: settingsContainer,
    userRepository: userRepository,
    firebaseUserRepository: firebaseUserRepository,
    roomRepository: roomRepository,
    dormitoryRepository: dormitoryRepository,
    requestRepository: requestRepository,
    chatRepository: chatRepository,
    chatRealTimeRepository: chatRealTimeRepository,
    messageRepository: messageRepository,
    messageRealTimeRepository: messageRealTimeRepository,
    problemRepository: problemRepository,
    masterRepository: masterRepository,
    studentRepository: studentRepository,
    materialRepository: materialRepository,
    materialTypeRepository: materialTypeRepository,
    instructionRepository: instructionRepository,
    authenticationBloc: authenticationBloc,
    specializationBloc: specializationBloc,
    dormitoryBloc: dormitoryBloc,
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

class _CreateHttpClient extends AsyncFactory<RestClientHttp> {
  const _CreateHttpClient({required this.authRepository});

  final IAuthRepository authRepository;

  @override
  Future<RestClientHttp> create() async {
    final list = <ApiClientMiddleware>[
      const LoggerMiddleware().call,

      AuthenticatedMiddleware(
        getToken: () async {
          try {
            return await FirebaseAuth.instance.currentUser?.getIdToken();
          } on Object catch (e, s) {
            Logger().w(
              'Failed to get authentication token',
              error: e,
              stackTrace: s,
            );
            return null;
          }
        },
        logout: () async {
          Logger().w('Authentication failed, logging out user');
          await authRepository.signOut();
        },
      ).call,
    ];

    return RestClientHttp(
      baseUrl: Config.apiBaseUrl,
      client: createDefaultHttpClient(),
      middleware: list,
    );
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
