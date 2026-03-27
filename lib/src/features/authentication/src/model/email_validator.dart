import '../../../../app/model/application_config.dart';

class EmailValidator {
  bool _isValidateEmail = false;
  String? _emailError;

  bool get isValidate => _isValidateEmail;
  String? get emailError => _emailError;

  String? emailValidator(String email) {
    if (email.isEmpty) {
      return 'Email is required.';
    } else if (!Config.email.hasMatch(email)) {
      return 'Must be a valid email.';
    }

    return null;
  }

  bool validate(String email) {
    _emailError = emailValidator(email);

    return _emailError == null;
  }

  void onEmailChanged(
    String email, {
    Function(String email)? onChange,
    Function(String email)? onValid,
    Function(String email)? onInvalid,
  }) {
    if (validate(email) && !isValidate) {
      _isValidateEmail = true;
      onChange?.call(email) ?? onValid?.call(email);
    } else if (!validate(email) && isValidate) {
      _isValidateEmail = false;
      onChange?.call(email) ?? onInvalid?.call(email);
    }
  }
}
