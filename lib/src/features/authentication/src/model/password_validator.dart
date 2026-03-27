import '../../../../app/model/application_config.dart';

class PasswordValidator {
  PasswordValidator._();
  static final instance = PasswordValidator._();
  factory PasswordValidator() => instance;

  bool _isValidatePassword = false;
  String? _passwordError;

  bool get isValidatePassword => _isValidatePassword;
  String? get passwordError => _passwordError;

  String? passwordValidator(String password) {
    const passwordMinLength = Config.passwordMinLength,
        passwordMaxLength = Config.passwordMaxLength;

    final length = switch (password.length) {
      0 => 'Password is required.',
      < passwordMinLength => 'Password must be 8 characters or more.',
      > passwordMaxLength => 'Password must be 32 characters or less.',
      _ => null,
    };

    if (length != null) return length;
    if (!password.contains(RegExp('[A-Z]'))) {
      return 'Password must have at least one uppercase character.';
    }
    if (!password.contains(RegExp('[a-z]'))) {
      return 'Password must have at least one lowercase character.';
    }
    if (!password.contains(RegExp('[0-9]'))) {
      return 'Password must have at least one number.';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must have at least one special character.';
    }

    return null;
  }

  bool validatePassword(String password) {
    _passwordError = passwordValidator(password);

    return passwordError == null;
  }

  void onPasswordChanged(
    String password, {
    Function(String password)? onChange,
    Function(String password)? onValid,
    Function(String password)? onInvalid,
  }) {
    if (validatePassword(password) && !isValidatePassword) {
      _isValidatePassword = true;
      onChange?.call(password) ?? onValid?.call(password);
    } else if (!validatePassword(password) && isValidatePassword) {
      _isValidatePassword = false;
      onChange?.call(password) ?? onInvalid?.call(password);
    }
  }
}
