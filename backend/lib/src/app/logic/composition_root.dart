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

    // Firebase
    final options = AppOptions(
      credential: FirebaseAdmin.instance.certFromPath(Config.serviceAccount),
    );

    final app = FirebaseAdmin.instance.initializeApp(options);

    // Database
    final database = Database.lazy(file: File(Config.databasePath));

    // WS
    final ws = WebSocketBase();

    // RestApi
    final restApi = RestApiBase();

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

    // Profile
    final profileRouter = ProfileRouter(
      restApi: restApi,
      studentRepository: studentRepository,
      masterRepository: masterRepository,
    );

    // Request
    final requestRepository = RequestRepositoryImpl(database: database);
    final repairRequestRouter = RepairRequestRouter(
      requestRepository: requestRepository,
      restApi: restApi,
      wsConnection: ws,
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

    // Chat
    final messageRepository = MessageRepositoryImpl(database: database);
    final chatRepository = ChatRepositoryImpl(database: database);
    final chatRouter = CharRouter(
      chatRepository: chatRepository,
      restApi: restApi,
    );
    final messageRouter = MessageRouter(
      messageRepository: messageRepository,
      restApi: restApi,
    );

    // RealTime
    final chatRealTimeRepository = ChatRealTimeRepositoryImpl(ws: ws);
    final messageRealTimeRepository = MessageRealTimeRepositoryImpl(
      messageRepository: messageRepository,
      chatRealTimeRepository: chatRealTimeRepository,
    );
    final wsRouter = WsRouter(
      ws: ws,
      chatRealTimeRepository: chatRealTimeRepository,
      messageRealTimeRepository: messageRealTimeRepository,
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
