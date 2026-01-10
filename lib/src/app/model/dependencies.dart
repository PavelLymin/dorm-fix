import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../core/rest_client/rest_client.dart';
import '../../core/ws/ws.dart';
import '../../features/authentication/authentication.dart';
import '../../features/dormitory/dormitory.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/repair_request/request.dart';
import '../../features/room/room.dart';
import '../../features/settings/settings.dart';
import '../router/router.dart';

class DependencyContainer {
  const DependencyContainer({
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
    required this.authenticationBloc,
    required this.profileBloc,
    required this.specializationBloc,
    required this.repairRequestBloc,
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

  // BloC
  final AuthBloc authenticationBloc;
  final ProfileBloc profileBloc;
  final SpecializationBloc specializationBloc;
  final RepairRequestBloc repairRequestBloc;
}
