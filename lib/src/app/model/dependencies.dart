import '../../core/rest_client/src/http/rest_client_http.dart';
import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.client,
    required this.authenticationBloc,
    required this.authButton,
  });

  final RestClientHttp client;

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;
}
