import '../../../../app/model/application_config.dart';

abstract class EmailPasswordValidator {
  static String? usernameError, passwordError;

  static String? emailValidator(String email) {
    if (email.isEmpty) {
      return 'Email is required.';
    } else if (!Config.email.hasMatch(email)) {
      return 'Must be a valid email.';
    }

    return null;
  }

  static String? passwordValidator(String password) {
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

  static bool validateEmail(String email) {
    usernameError = emailValidator(email);

    return usernameError == null;
  }

  static bool validatePassword(String password) {
    passwordError = passwordValidator(password);

    return passwordError == null;
  }
}
