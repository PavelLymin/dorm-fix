import 'package:logger/logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';
import '../../features/yandex_mapkit/state_management/pins/bloc/pins_bloc.dart';
import '../../features/yandex_mapkit/state_management/search/search_bloc.dart';
import '../router/router.dart';

class DependencyContainer {
  const DependencyContainer({
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
    required this.pinsBloc,
    required this.specializationBloc,
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

  final SpecializationBloc specializationBloc;
}
