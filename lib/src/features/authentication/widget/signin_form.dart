import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../state_management/auth_button/auth_button_bloc.dart';
import '../state_management/authentication/authentication_bloc.dart';
import 'auth_button.dart';
import 'email_password_form.dart';
import 'phone_number_form.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with _FormStateMixin {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 16),
      WindowSizeScope.of(context).isMediumOrLarger
          ? UiText.titleLarge(
              'Начните использовать приложение',
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          : UiText.titleMedium(
              'Начните использовать приложение',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
      const SizedBox(height: 32),
      ValueListenableBuilder(
        valueListenable: _isPhoneNumber,
        builder: (context, value, _) => !value
            ? EmailPasswordForm(
                emailController: _emailController,
                passwordController: _passwordController,
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
                onTap: () {},
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
      const SizedBox(height: 32),
      AuthButton(
        signInWithEmailAndPassword: () => _signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        ),
        signInWithPhoneNumber: () =>
            _signInWithPhoneNumber(_pinCodeController.text),
        verifyPhoneNumber: () => _verifyPhoneNumber(_phoneController.text),
      ),
    ],
  );
}

mixin _FormStateMixin on State<SignInForm> {
  late AuthBloc _authBloc;
  bool _clearText = false;
  final _isPhoneNumber = ValueNotifier<bool>(false);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _phoneController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _authBloc = DependeciesScope.of(context).authenticationBloc;
    _emailController.addListener(_emailToPhoneNumber);
    _phoneController.addListener(_phoneNumberToEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_emailToPhoneNumber);
    _phoneController.removeListener(_phoneNumberToEmail);
    super.dispose();
  }

  void _emailToPhoneNumber() {
    _onChanged(_emailController.text);
    if (_emailController.text.startsWith('+')) {
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        setState(() {
          _phoneController.text = _emailController.text;
          _emailController.clear();
          _isPhoneNumber.value = true;
          _emailFocusNode.unfocus();
          _phoneFocusNode.requestFocus();
        });
      });
    }
  }

  void _phoneNumberToEmail() {
    _onChanged(_phoneController.text);
    if (!_phoneController.text.startsWith('+')) {
      Future.delayed(Duration(milliseconds: 100)).then(
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
      setState(() {
        _clearText = true;
      });
    } else if (text.isEmpty && _clearText) {
      setState(() {
        _clearText = false;
      });
    }
  }

  void _signInWithEmailAndPassword(String email, String password) {
    _authBloc.add(
      AuthEvent.signInWithEmailAndPassword(email: email, password: password),
    );
  }

  void _verifyPhoneNumber(String phoneNumber) {
    _authBloc.add(AuthEvent.verifyPhoneNumber(phoneNumber: phoneNumber));
  }

  void _signInWithPhoneNumber(String smsCode) {
    _authBloc.state.mapOrNull(
      smsCodeSent: (state) => context.read<AuthBloc>().add(
        AuthEvent.signInWithPhoneNumber(
          verificationId: state.verificationId,
          smsCode: smsCode,
        ),
      ),
    );
  }
}
