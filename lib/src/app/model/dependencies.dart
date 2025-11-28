import 'package:dorm_fix/src/app/router/router.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/state_management/pins/bloc/pins_bloc.dart';
import 'package:dorm_fix/src/features/settings/settings.dart';
import 'package:logger/logger.dart';
import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/data/repository/specialization_repository.dart';
import '../../features/yandex_mapkit/state_management/search/search_bloc.dart';
import '../../features/profile/state_management/profile_bloc/profile_bloc.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.client,
    required this.router,
    required this.searchBloc,
    required this.logger,
    required this.settingsContainer,
    required this.authenticationBloc,
    required this.profileBloc,
    required this.authButton,
    required this.pinsBloc,
    required this.specializationRepository,
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
}
