import '../../../../app/model/application_config.dart';

class PinCodeValidator {
  PinCodeValidator._();
  static final _instance = PinCodeValidator._();
  factory PinCodeValidator() => _instance;

  bool _isValidatePinCode = false;
  String? _pinCodeError;

  bool get isValidatePinCode => _isValidatePinCode;
  String? get pinCodeError => _pinCodeError;

  String? pinCodeValidator(String pinCode) {
    if (pinCode.isEmpty) {
      return 'Please enter pin code';
    } else if (pinCode.length != Config.pinCodeLength) {
      return 'Please enter valid pin code';
    }

    return null;
  }

  bool validatePinCode(String pinCode) {
    _pinCodeError = pinCodeValidator(pinCode);

    return pinCodeError == null;
  }

  void onPinCodeChanged(
    String pinCode, {
    Function(String pinCode)? onChange,
    Function(String pinCode)? onValid,
    Function(String pinCode)? onInvalid,
  }) {
    if (validatePinCode(pinCode) && !_isValidatePinCode) {
      _isValidatePinCode = true;
      onChange?.call(pinCode) ?? onValid?.call(pinCode);
    } else if (!validatePinCode(pinCode) && _isValidatePinCode) {
      _isValidatePinCode = false;
      onChange?.call(pinCode) ?? onInvalid?.call(pinCode);
    }
  }
}
