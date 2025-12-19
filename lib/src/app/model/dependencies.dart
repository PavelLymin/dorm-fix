import 'package:dorm_fix/src/features/request/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/ws/ws.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/room/room.dart';
import '../../features/settings/settings.dart';
import '../../features/yandex_mapkit/yandex_mapkit.dart';
import '../router/router.dart';

class DependencyContainer {
  const DependencyContainer({
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
    required this.dormitorySearchBloc,
    required this.dormitoryRepository,
    required this.specializationBloc,
    required this.roomRepository,
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

  final IRequestRepository requestRepository;

  final RepairRequestBloc repairRequestBloc;
}
