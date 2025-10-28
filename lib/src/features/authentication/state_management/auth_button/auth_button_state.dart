part of 'auth_button_bloc.dart';

class AuthButtonState {
  const AuthButtonState({
    bool isLoading = false,
    bool isEmail = false,
    bool isPassword = false,
    bool isPhoneNumber = false,
    bool isPin = false,
    bool isCodeSent = false,
  }) : _isLoading = isLoading,
       _isEmail = isEmail,
       _isPassword = isPassword,
       _isPhoneNumber = isPhoneNumber,
       _isPin = isPin,
       _isCodeSent = isCodeSent;

  final bool _isLoading;
  final bool _isEmail;
  final bool _isPassword;
  final bool _isPhoneNumber;
  final bool _isPin;
  final bool _isCodeSent;

  bool get isEnabled {
    if (_isLoading) {
      return false;
    } else if (_isEmail && _isPassword) {
      return true;
    } else if (_isPhoneNumber && !_isCodeSent) {
      return true;
    } else if (_isPin && _isCodeSent) {
      return true;
    }

    return false;
  }

  AuthButtonState copyWith({
    bool? isLoading,
    bool? isEmail,
    bool? isPassword,
    bool? isPhoneNumber,
    bool? isPin,
    bool? isCodeSent,
  }) => AuthButtonState(
    isLoading: isLoading ?? _isLoading,
    isEmail: isEmail ?? _isEmail,
    isPassword: isPassword ?? _isPassword,
    isPhoneNumber: isPhoneNumber ?? _isPhoneNumber,
    isPin: isPin ?? _isPin,
    isCodeSent: isCodeSent ?? _isCodeSent,
  );

  T map<T>({
    required T Function() isLoading,
    required T Function() isEmailPassword,
    required T Function() isPhoneNumber,
    required T Function() isPin,
  }) {
    if (_isEmail && _isPassword) {
      return isEmailPassword();
    } else if (_isPhoneNumber && !_isCodeSent) {
      return isPhoneNumber();
    } else if (_isPhoneNumber && _isCodeSent) {
      return isPin();
    } else {
      return isLoading();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? isEmailPassword,
    T Function()? isPhoneNumber,
    T Function()? isPin,
  }) => map(
    isLoading: () => orElse(),
    isEmailPassword: isEmailPassword ?? () => orElse(),
    isPhoneNumber: isPhoneNumber ?? () => orElse(),
    isPin: isPin ?? () => orElse(),
  );

  T? mapOrNull<T>({
    T Function()? isEmailPassword,
    T Function()? isPhoneNumber,
    T Function()? isPin,
  }) => map(
    isLoading: () => null,
    isEmailPassword: isEmailPassword ?? () => null,
    isPhoneNumber: isPhoneNumber ?? () => null,
    isPin: isPin ?? () => null,
  );

  bool get isLoading => _isLoading;

  @override
  String toString() =>
      'AuthButtonState(isLoading: $_isLoading, isEmail: $_isEmail, isPassword: $_isPassword, isPhoneNumber: $_isPhoneNumber, isPin: $_isPin, isCodeSent: $_isCodeSent)';
}
