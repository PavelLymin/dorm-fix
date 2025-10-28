import '../../features/authentication/state_management/auth_button/auth_button_bloc.dart';
import '../../features/authentication/state_management/authentication/authentication_bloc.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.authenticationBloc,
    required this.authButton,
  });

  final AuthBloc authenticationBloc;

  final AuthButtonBloc authButton;
}
