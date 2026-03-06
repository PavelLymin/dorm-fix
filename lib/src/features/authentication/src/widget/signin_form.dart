import 'package:ui_kit/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../authentication.dart';
import 'auth_button.dart';
import 'email_password_form.dart';
import 'phone_number_form.dart';

class _ChoiceLogIn extends StatelessWidget {
  const _ChoiceLogIn({required this.isSignIn});

  final ValueNotifier<bool> isSignIn;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: isSignIn,
    builder: (_, value, _) => ChoiceOptions(
      options: <ChoiceItem>[
        ChoiceItem(title: 'Регистрация'),
        ChoiceItem(title: 'Вход'),
      ],
      selected: value ? 1 : 0,
      onChange: (_) => isSignIn.value = !value,
    ),
  );
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with _FormStateMixin {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    crossAxisAlignment: .stretch,
    mainAxisSize: .min,
    spacing: 32.0,
    children: [
      _ChoiceLogIn(isSignIn: _isSignIn),
      ValueListenableBuilder(
        valueListenable: _isPhoneNumber,
        builder: (context, value, _) => !value
            ? EmailPasswordForm(
                emailController: _emailController,
                passwordController: _passwordController,
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
              )
            : BlocBuilder<AuthButtonBloc, AuthButtonState>(
                buildWhen: (previous, current) {
                  bool wasPin = previous.maybeMap(
                    isPin: () => true,
                    orElse: () => false,
                  );
                  bool isPin = current.maybeMap(
                    isPin: () => true,
                    orElse: () => false,
                  );
                  return wasPin != isPin;
                },
                builder: (context, state) => state.maybeMap(
                  orElse: () => PhoneNumberForm(
                    phoneController: _phoneController,
                    pinCodeController: _pinCodeController,
                    phoneFocusNode: _phoneFocusNode,
                    isEnabledTextField: true,
                    isEnabledPinCode: false,
                  ),
                  isPin: () => PhoneNumberForm(
                    phoneFocusNode: _phoneFocusNode,
                    phoneController: _phoneController,
                    pinCodeController: _pinCodeController,
                    isEnabledTextField: false,
                    isEnabledPinCode: true,
                    onTap: () {},
                  ),
                ),
              ),
      ),
      AuthButton(
        emailAndPassword: () => _logInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        ),
        phoneNumber: () => _signInWithPhoneNumber(_pinCodeController.text),
        verifyPhoneNumber: () => _verifyPhoneNumber(_phoneController.text),
      ),
    ],
  );
}

mixin _FormStateMixin on State<SignInForm> {
  late final AuthBloc _authBloc;
  late final ValueNotifier<bool> _isSignIn;
  late final ValueNotifier<bool> _isPhoneNumber;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  bool _clearText = false;

  @override
  void initState() {
    super.initState();
    _authBloc = DependeciesScope.of(context).authenticationBloc;
    _isSignIn = ValueNotifier<bool>(true);
    _isPhoneNumber = ValueNotifier<bool>(false);
    _emailController.addListener(_emailToPhoneNumber);
    _phoneController.addListener(_phoneNumberToEmail);
  }

  @override
  void dispose() {
    _isSignIn.dispose();
    _emailController.removeListener(_emailToPhoneNumber);
    _phoneController.removeListener(_phoneNumberToEmail);
    super.dispose();
  }

  void _emailToPhoneNumber() {
    _onChanged(_emailController.text);
    if (_emailController.text.startsWith('+')) {
      Future.delayed(const Duration(milliseconds: 100)).then(
        (_) => setState(() {
          _phoneController.text = _emailController.text;
          _emailController.clear();
          _isPhoneNumber.value = true;
          _emailFocusNode.unfocus();
          _phoneFocusNode.requestFocus();
        }),
      );
    }
  }

  void _phoneNumberToEmail() {
    _onChanged(_phoneController.text);
    if (!_phoneController.text.startsWith('+')) {
      Future.delayed(const Duration(milliseconds: 100)).then(
        (_) => setState(() {
          _emailController.text = _phoneController.text;
          _pinCodeController.clear();
          _phoneController.clear();
          _isPhoneNumber.value = false;
          _phoneFocusNode.unfocus();
          _emailFocusNode.requestFocus();
        }),
      );
    }
  }

  void _onChanged(String text) {
    if (text.isNotEmpty && !_clearText) {
      setState(() => _clearText = true);
    } else if (text.isEmpty && _clearText) {
      setState(() => _clearText = false);
    }
  }

  void _logInWithEmailAndPassword(String email, String password) =>
      _isSignIn.value
      ? _authBloc.add(
          .signInWithEmailAndPassword(email: email, password: password),
        )
      : _authBloc.add(
          .signUpWithEmailAndPassword(email: email, password: password),
        );

  void _verifyPhoneNumber(String phoneNumber) =>
      _authBloc.add(.verifyPhoneNumber(phoneNumber: phoneNumber));

  void _signInWithPhoneNumber(String smsCode) => _authBloc.state.mapOrNull(
    smsCodeSent: (state) => _authBloc.add(
      .signInWithPhoneNumber(
        verificationId: state.verificationId,
        smsCode: smsCode,
      ),
    ),
  );
}
