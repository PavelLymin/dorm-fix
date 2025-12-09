import 'package:dorm_fix/src/features/room/state_management/room_search_bloc/room_search_bloc_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';
import '../../features/yandex_mapkit/state_management/pins_bloc/pins_bloc.dart';
import '../../features/yandex_mapkit/state_management/dormitory_search_bloc/dormitory_search_bloc.dart';
import '../router/router.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.firebaseAuth,
    required this.client,
    required this.router,
    required this.logger,
    required this.settingsContainer,
    required this.authenticationBloc,
    required this.profileBloc,
    required this.userRepository,
    required this.firebaseUserRepository,
    required this.authButton,
    required this.dormitorySearchBloc,
    required this.pinsBloc,
    required this.specializationBloc,
    required this.roomSearcBloc,
  });

  final FirebaseAuth firebaseAuth;

  final RestClientHttp client;

  final AppRouter router;

  final Logger logger;

  final SettingsContainer settingsContainer;

  final AuthBloc authenticationBloc;

  final ProfileBloc profileBloc;

  final IUserRepository userRepository;

  final IFirebaseUserRepository firebaseUserRepository;

  final AuthButtonBloc authButton;

  final DormitorySearchBloc dormitorySearchBloc;

  final RoomSearcBloc roomSearcBloc;

  final PinsBloc pinsBloc;

  final SpecializationBloc specializationBloc;
}
