import '../../../app/model/application_config.dart';

abstract class PhoneNumberValidator {
  static String? phoneNumberError, pinCodeError;

  static String? phoneNumberValidator(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Please enter mobile number';
    } else if (!Config.phoneNumber.hasMatch(phoneNumber)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  static String? pinCodeValidator(String pinCode) {
    if (pinCode.isEmpty) {
      return 'Please enter pin code';
    } else if (pinCode.length != 6) {
      return 'Please enter valid pin code';
    }

    return null;
  }

  static bool validatePhoneNumber(String phoneNumber) {
    phoneNumberError = phoneNumberValidator(phoneNumber);

    return phoneNumberError == null;
  }

  static bool validatePinCode(String pinCode) {
    pinCodeError = pinCodeValidator(pinCode);

    return pinCodeError == null;
  }
}
