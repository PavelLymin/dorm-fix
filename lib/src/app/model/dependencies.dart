import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';
import '../../features/home/state_management/bloc/specialization_bloc.dart';
import '../../shared/student/state_management/bloc/student_bloc.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.client,
    required this.authenticationBloc,
    required this.authButton,
    required this.studentBloc,
    required this.specializationBloc,
  });

  final RestClientHttp client;

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;

  final StudentBloc studentBloc;

  final SpecializationBloc specializationBloc;
}
