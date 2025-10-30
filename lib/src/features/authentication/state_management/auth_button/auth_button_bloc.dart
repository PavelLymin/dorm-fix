import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_button_event.dart';
part 'auth_button_state.dart';

class AuthButtonBloc extends Bloc<AuthButtonEvent, AuthButtonState> {
  AuthButtonBloc([super.initialState = const AuthButtonState()]) {
    on<AuthButtonEvent>((event, emit) {
      event.map(
        addIsLoaded: (s) => _addIsLoaded(s, emit),
        addIsEmail: (s) => _addIsEmail(s, emit),
        addIsPassword: (s) => _addIsPassword(s, emit),
        addIsPhoneNumber: (s) => _addIsPhoneNumber(s, emit),
        addIsPin: (s) => _addIsPin(s, emit),
        addIsCodeSent: (s) => _addIsCodeSent(s, emit),
      );
    });
  }

  void _addIsLoaded(_AddIsLoaded event, Emitter<AuthButtonState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _addIsEmail(_AddIsEmail event, Emitter<AuthButtonState> emit) {
    emit(state.copyWith(isEmail: event.isEmail));
  }

  void _addIsPassword(_AddIsPassword event, Emitter<AuthButtonState> emit) {
    emit(state.copyWith(isPassword: event.isPassword));
  }

  void _addIsPhoneNumber(
    _AddIsPhoneNumber event,
    Emitter<AuthButtonState> emit,
  ) {
    emit(state.copyWith(isPhoneNumber: event.isPhoneNumber));
  }

  void _addIsPin(_AddIsPin event, Emitter<AuthButtonState> emit) {
    emit(state.copyWith(isPin: event.isPin));
  }

  void _addIsCodeSent(_AddIsCodeSent event, Emitter<AuthButtonState> emit) {
    emit(state.copyWith(isCodeSent: event.isCodeSent));
  }
}
