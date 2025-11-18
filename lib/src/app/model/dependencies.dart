import 'package:dorm_fix/src/app/router/router.dart';

import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/state_management/bloc/specialization_bloc.dart';
import '../../features/profile/student/state_management/bloc/student_bloc.dart';
import '../../features/yandex_map/state_management/bloc/search_bloc.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.client,
    required this.router,
    required this.authenticationBloc,
    required this.authButton,
    required this.studentBloc,
    required this.specializationBloc,
    required this.searchBloc,
  });

  final RestClientHttp client;

  final AppRouter router;

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;

  final StudentBloc studentBloc;

  final SpecializationBloc specializationBloc;

  final SearchBloc searchBloc;
}
