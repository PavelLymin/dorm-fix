import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_button_event.dart';
part 'auth_button_state.dart';

class AuthButtonBloc extends Bloc<AuthButtonEvent, AuthButtonState> {
  AuthButtonBloc([super.initialState = const AuthButtonState()]) {
    on<AuthButtonEvent>((event, emit) {
      switch (event) {
        case _ChangeState s:
          _addIsLoaded(s, emit);
      }
    });
  }

  void _addIsLoaded(_ChangeState event, Emitter<AuthButtonState> emit) {
    emit(
      AuthButtonState(
        isLoading: event.isLoading ?? state._isLoading,
        isCodeSent: event.isCodeSent ?? state._isCodeSent,
        isEmail: event.isEmail ?? state._isEmail,
        isPassword: event.isPassword ?? state._isPassword,
        isPhoneNumber: event.isPhoneNumber ?? state._isPhoneNumber,
        isPin: event.isPin ?? state._isPin,
      ),
    );
  }
}
