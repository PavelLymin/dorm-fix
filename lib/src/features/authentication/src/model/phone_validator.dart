import '../../../../app/model/application_config.dart';

class PhoneValidator {
  bool _isValidate = false;
  String? _phoneNumberError;

  bool get isValidate => _isValidate;
  String? get phoneNumberError => _phoneNumberError;

  String? phoneNumberValidator(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Please enter mobile number';
    } else if (!Config.phoneNumber.hasMatch(phoneNumber)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  bool validate(String phoneNumber) {
    _phoneNumberError = phoneNumberValidator(phoneNumber);

    return phoneNumberError == null;
  }

  void onPhoneChanged(
    String phoneNumber, {
    Function(String phoneNumber)? onChange,
    Function(String phoneNumber)? onValid,
    Function(String phoneNumber)? onInvalid,
  }) {
    if (validate(phoneNumber) && !isValidate) {
      _isValidate = true;
      onChange?.call(phoneNumber) ?? onValid?.call(phoneNumber);
    } else if (!validate(phoneNumber) && _isValidate) {
      _isValidate = false;
      onChange?.call(phoneNumber) ?? onInvalid?.call(phoneNumber);
    }
  }
}
