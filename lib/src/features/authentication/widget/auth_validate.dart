part of 'signin.dart';

mixin _EmailPasswordPhoneNumberFormStateMixin on State<SignIn> {
  bool isValidate = false;

  static String? _emailValidator(String email) {
    if (email.isEmpty) {
      return 'Email is required.';
    } else if (!Config.email.hasMatch(email)) {
      return 'Must be a valid email.';
    }

    return null;
  }

  static String? _passwordValidator(String password) {
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

  static String? _phoneNumberValidator(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Please enter mobile number';
    } else if (!Config.phoneNumber.hasMatch(phoneNumber)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  static String? _pinCodeValidator(String pinCode) {
    if (pinCode.isEmpty) {
      return 'Please enter pin code';
    } else if (pinCode.length != 6) {
      return 'Please enter valid pin code';
    }

    return null;
  }

  // ignore: unused_field
  String? _usernameError, _passwordError, _phoneNumberError, _pinCodeError;

  bool _validateEmail(String email) {
    _usernameError = _emailValidator(email);

    return _usernameError == null;
  }

  bool _validatePassword(String password) {
    _passwordError = _passwordValidator(password);

    return _passwordError == null;
  }

  bool _validatePhoneNumber(String phoneNumber) {
    _phoneNumberError = _phoneNumberValidator(phoneNumber);

    return _phoneNumberError == null;
  }

  bool _validatePinCode(String pinCode) {
    _pinCodeError = _pinCodeValidator(pinCode);

    return _pinCodeError == null;
  }

  void _signInWithEmailAndPassword(String email, String password) {
    context.read<AuthBloc>().add(
      AuthEvent.signInWithEmailAndPassword(email: email, password: password),
    );
  }

  void _verifyPhoneNumber(String phoneNumber) {
    context.read<AuthBloc>().add(
      AuthEvent.verifyPhoneNumber(phoneNumber: phoneNumber),
    );
  }

  void _signInWithPhoneNumber(String smsCode) {
    context.read<AuthBloc>().state.mapOrNull(
      smsCodeSent: (state) => context.read<AuthBloc>().add(
        AuthEvent.signInWithPhoneNumber(
          verificationId: state.verificationId,
          smsCode: smsCode,
        ),
      ),
    );
  }
}
