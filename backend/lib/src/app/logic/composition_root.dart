import 'dart:io';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:logger/web.dart';

import '../../core/database/database.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../../core/ws/ws.dart';
import '../../server/chat/chat.dart';
import '../../server/chat/src/router/message.dart';
import '../../server/dormitory/dormitory.dart';
import '../../server/profile/profile.dart';
import '../../server/repair_request/repair_request.dart';
import '../../server/room/room.dart';
import '../../server/specialization/specialization.dart';
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

    // <--- Services --->
    // Firebase
    final options = AppOptions(
      credential: FirebaseAdmin.instance.certFromPath(Config.serviceAccount),
    );
    final app = FirebaseAdmin.instance.initializeApp(options);

    // Database
    final database = Database.lazy(file: File(Config.databasePath));

    // RestApi
    final restApi = RestApiBase();

    // WS
    final ws = WebSocketBase();

    // <--- Repositories --->
    // User
    final userRepository = UserRepositoryImpl(database: database);
    final userRouter = UserRouter(
      userRepository: userRepository,
      restApi: restApi,
    );
    // Student
    final studentRepository = StudentRepositoryImpl(database: database);
    // Master
    final masterRepository = MasterRepository(database: database);
    // Problem
    final problemRepository = ProblemRepositoryImpl(database: database);
    // Specialization
    final specializationRepository = SpecializationRepositoryImpl(
      database: database,
    );
    // Dormitory
    final dormitoryRepository = DormitoryRepository(database: database);
    final dormitoryRouter = DormitoryRouter(
      dormitoryRepository: dormitoryRepository,
      restApi: restApi,
    );
    // Room
    final roomRepository = RoomRepository(database: database);
    // Message
    final messageRepository = MessageRepositoryImpl(database: database);
    // Chat
    final chatRepository = ChatRepositoryImpl(database: database);
    final assignmentsRepository = AssignmentsRepositoryImpl(database: database);
    // RepairRequest
    final requestRepository = RequestRepositoryImpl(database: database);
    final requestFacade = RepairRequestFacadeImpl(
      database: database,
      requestRepository: requestRepository,
      problemRepository: problemRepository,
      chatRepository: chatRepository,
      specializationRepository: specializationRepository,
      assignmentsRepository: assignmentsRepository,
    );

    // <--- RealTime Repositories --->
    // Chat
    final chatRealTimeRepository = ChatRealTimeRepositoryImpl(ws: ws);
    // Message
    final messageRealTimeRepository = MessageRealTimeRepositoryImpl(
      messageRepository: messageRepository,
      chatRealTimeRepository: chatRealTimeRepository,
    );

    // <--- Routers --->
    // WS
    final wsRouter = WsRouter(
      ws: ws,
      chatRealTimeRepository: chatRealTimeRepository,
      messageRealTimeRepository: messageRealTimeRepository,
    );
    // Profile
    final profileRouter = ProfileRouter(
      restApi: restApi,
      studentRepository: studentRepository,
      masterRepository: masterRepository,
    );
    // Specialization
    final specializationRouter = SpecializationRouter(
      specializationRepository: specializationRepository,
      restApi: restApi,
    );
    // Room
    final roomRouter = RoomRouter(
      roomRepository: roomRepository,
      restApi: restApi,
    );
    // Message
    final messageRouter = MessageRouter(
      messageRepository: messageRepository,
      restApi: restApi,
    );
    // Chat
    final chatRouter = CharRouter(
      chatRepository: chatRepository,
      restApi: restApi,
    );
    // RepairRequest
    final repairRequestRouter = RepairRequestRouter(
      requestRepository: requestRepository,
      requestFacade: requestFacade,
      restApi: restApi,
      wsConnection: ws,
    );

    return _DependencyFactory(
      firebaseAdmin: app,
      restApi: restApi,
      wsRouter: wsRouter,
      database: database,
      userRouter: userRouter,
      repairRequestRouter: repairRequestRouter,
      profileRouter: profileRouter,
      dormitoryRouter: dormitoryRouter,
      roomRouter: roomRouter,
      specializationRouter: specializationRouter,
      chatRouter: chatRouter,
      messageRouter: messageRouter,
    ).create();
  }
}

class _DependencyFactory extends Factory<DependencyContainer> {
  const _DependencyFactory({
    required this.firebaseAdmin,
    required this.restApi,
    required this.wsRouter,
    required this.database,
    required this.userRouter,
    required this.repairRequestRouter,
    required this.profileRouter,
    required this.dormitoryRouter,
    required this.roomRouter,
    required this.specializationRouter,
    required this.chatRouter,
    required this.messageRouter,
  });

  final App firebaseAdmin;

  final RestApi restApi;

  final WsRouter wsRouter;

  final Database database;

  final UserRouter userRouter;

  final RepairRequestRouter repairRequestRouter;

  final ProfileRouter profileRouter;

  final DormitoryRouter dormitoryRouter;

  final RoomRouter roomRouter;

  final SpecializationRouter specializationRouter;

  final CharRouter chatRouter;

  final MessageRouter messageRouter;

  @override
  DependencyContainer create() => DependencyContainer(
    firebaseAdmin: firebaseAdmin,
    restApi: restApi,
    wsRouter: wsRouter,
    database: database,
    userRouter: userRouter,
    repairRequestRouter: repairRequestRouter,
    profileRouter: profileRouter,
    dormitoryRouter: dormitoryRouter,
    roomRouter: roomRouter,
    specializationRouter: specializationRouter,
    chatRouter: chatRouter,
    messageRouter: messageRouter,
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
