part of 'auth_button_bloc.dart';

sealed class AuthButtonEvent {
  const AuthButtonEvent();

  const factory AuthButtonEvent.changeState({
    bool? isLoading,
    bool? isEmail,
    bool? isPassword,
    bool? isPhoneNumber,
    bool? isPin,
    bool? isCodeSent,
  }) = _ChangeState;
}

class _ChangeState extends AuthButtonEvent {
  const _ChangeState({
    this.isLoading,
    this.isEmail,
    this.isPassword,
    this.isPhoneNumber,
    this.isPin,
    this.isCodeSent,
  });

  final bool? isLoading;
  final bool? isEmail;
  final bool? isPassword;
  final bool? isPhoneNumber;
  final bool? isPin;
  final bool? isCodeSent;
}
