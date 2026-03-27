class NameValidator {
  bool _isValidateName = false;
  String? _userNameError;

  bool get isValid => _isValidateName;
  String? get userNameError => _userNameError;

  String? nameValidator(String userName) {
    if (userName.trim().isEmpty) return 'Please enter name';

    return null;
  }

  bool validate(String userName) {
    _userNameError = nameValidator(userName);

    return _isValidateName = _userNameError == null;
  }

  void onNameChanged(
    String userName, {
    Function(String userName)? onChange,
    Function(String userName)? onValid,
    Function(String userName)? onInvalid,
  }) {
    if (validate(userName) && !_isValidateName) {
      _isValidateName = true;
      onChange?.call(userName) ?? onValid?.call(userName);
    } else if (!validate(userName) && _isValidateName) {
      _isValidateName = false;
      onChange?.call(userName) ?? onInvalid?.call(userName);
    }
  }
}
