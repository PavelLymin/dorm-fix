import 'package:dorm_fix/src/features/authentication/state_management/bloc/authentication_bloc.dart';

class DependencyContainer {
  const DependencyContainer({required this.authenticationBloc});

  final AuthenticationBloc authenticationBloc;
}
