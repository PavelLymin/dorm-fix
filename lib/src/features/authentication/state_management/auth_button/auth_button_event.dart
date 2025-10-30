part of 'auth_button_bloc.dart';

sealed class AuthButtonEvent {
  const AuthButtonEvent();

  const factory AuthButtonEvent.addIsLoaded({required bool isLoading}) =
      _AddIsLoaded;

  const factory AuthButtonEvent.addIsEmail({required bool isEmail}) =
      _AddIsEmail;

  const factory AuthButtonEvent.addIsPassword({required bool isPassword}) =
      _AddIsPassword;

  const factory AuthButtonEvent.addIsPhoneNumber({
    required bool isPhoneNumber,
  }) = _AddIsPhoneNumber;

  const factory AuthButtonEvent.addIsPin({required bool isPin}) = _AddIsPin;

  const factory AuthButtonEvent.addIsCodeSent({required bool isCodeSent}) =
      _AddIsCodeSent;

  T map<T>({
    required T Function(_AddIsLoaded event) addIsLoaded,
    required T Function(_AddIsEmail event) addIsEmail,
    required T Function(_AddIsPassword event) addIsPassword,
    required T Function(_AddIsPhoneNumber event) addIsPhoneNumber,
    required T Function(_AddIsPin event) addIsPin,
    required T Function(_AddIsCodeSent event) addIsCodeSent,
  }) => switch (this) {
    _AddIsLoaded e => addIsLoaded(e),
    _AddIsEmail e => addIsEmail(e),
    _AddIsPassword e => addIsPassword(e),
    _AddIsPhoneNumber e => addIsPhoneNumber(e),
    _AddIsPin e => addIsPin(e),
    _AddIsCodeSent e => addIsCodeSent(e),
  };
}

class _AddIsLoaded extends AuthButtonEvent {
  const _AddIsLoaded({required this.isLoading});

  final bool isLoading;
}

class _AddIsEmail extends AuthButtonEvent {
  const _AddIsEmail({required this.isEmail});

  final bool isEmail;
}

class _AddIsPassword extends AuthButtonEvent {
  const _AddIsPassword({required this.isPassword});

  final bool isPassword;
}

class _AddIsPhoneNumber extends AuthButtonEvent {
  const _AddIsPhoneNumber({required this.isPhoneNumber});

  final bool isPhoneNumber;
}

class _AddIsPin extends AuthButtonEvent {
  const _AddIsPin({required this.isPin});

  final bool isPin;
}

class _AddIsCodeSent extends AuthButtonEvent {
  const _AddIsCodeSent({required this.isCodeSent});

  final bool isCodeSent;
}
