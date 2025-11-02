import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/model/application_config.dart';
import '../state_management/auth_button/auth_button_bloc.dart';
import 'auth_button.dart';
import 'signin_form.dart';
import '../state_management/authentication/authentication_bloc.dart';
import 'signin_social.dart';
part 'auth_validate.dart';

@RoutePage()
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn>
    with _EmailPasswordPhoneNumberFormStateMixin {
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinCodeController = TextEditingController();
  bool _isLoading = false;
  bool _isValidatePassword = false;
  bool _isValidateEmail = false;
  bool _isValidatePhone = false;
  bool _isPinValidate = false;
  bool _isSmsCode = false;
  // StreamSubscription? _pinStreamSubscription;
  late AuthButtonBloc _authButtonBloc;

  @override
  void initState() {
    super.initState();
    _authButtonBloc = DependeciesScope.of(context).authButton;
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _phoneController.addListener(_onPhoneChanged);
    _pinCodeController.addListener(_onPinChanged);
    // _onPinChanged();
  }

  void _onEmailChanged() {
    if (_validateEmail(_emailController.text) && !_isValidateEmail) {
      _isValidateEmail = true;
      _authButtonBloc.add(AuthButtonEvent.addIsEmail(isEmail: true));
    } else if (!_validateEmail(_emailController.text) && _isValidateEmail) {
      _isValidateEmail = false;
      _authButtonBloc.add(AuthButtonEvent.addIsEmail(isEmail: false));
    }
  }

  void _onPasswordChanged() {
    if (_validatePassword(_passwordController.text) && !_isValidatePassword) {
      _isValidatePassword = true;
      _authButtonBloc.add(AuthButtonEvent.addIsPassword(isPassword: true));
    } else if (!_validatePassword(_passwordController.text) &&
        _isValidatePassword) {
      _isValidatePassword = false;
      _authButtonBloc.add(AuthButtonEvent.addIsPassword(isPassword: false));
    }
  }

  void _onPhoneChanged() {
    if (_validatePhoneNumber(_phoneController.text) && !_isValidatePhone) {
      _isValidatePhone = true;
      _authButtonBloc.add(
        AuthButtonEvent.addIsPhoneNumber(isPhoneNumber: true),
      );
    } else if (!_validatePhoneNumber(_phoneController.text) &&
        _isValidatePhone) {
      _isValidatePhone = false;
      _authButtonBloc.add(
        AuthButtonEvent.addIsPhoneNumber(isPhoneNumber: false),
      );
    }
  }

  void _onPinChanged() {
    if (_validatePinCode(_pinCodeController.text) && !_isPinValidate) {
      _isPinValidate = true;
      _authButtonBloc.add(AuthButtonEvent.addIsPin(isPin: true));
    } else if (!_validatePinCode(_pinCodeController.text) && _isPinValidate) {
      _isPinValidate = false;
      _authButtonBloc.add(AuthButtonEvent.addIsPin(isPin: false));
    }
  }

  void _addLoading(bool state) {
    if (!_isLoading && state) {
      _authButtonBloc.add(AuthButtonEvent.addIsLoaded(isLoading: true));
      _isLoading = true;
    } else if (_isLoading && !state) {
      _authButtonBloc.add(AuthButtonEvent.addIsLoaded(isLoading: false));
      _isLoading = false;
    }
  }

  void _addSmsCodeSent(bool state) {
    if (!_isSmsCode && state) {
      _authButtonBloc.add(AuthButtonEvent.addIsCodeSent(isCodeSent: true));
      _isSmsCode = true;
    } else if (_isSmsCode && !state) {
      _authButtonBloc.add(AuthButtonEvent.addIsCodeSent(isCodeSent: false));
      _isSmsCode = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.removeListener(_onEmailChanged);
    _passwordController.removeListener(_onPasswordChanged);
    _phoneController.removeListener(_onPhoneChanged);
    _pinCodeController.removeListener(_onPinChanged);
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    // _pinStreamSubscription?.cancel();
    _authButtonBloc.close();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _authButtonBloc,
    child: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () {
            _addLoading(false);
            _addSmsCodeSent(false);
          },
          loading: (_) {
            _addLoading(true);
            _addSmsCodeSent(false);
          },
          authenticated: (_) {
            _addLoading(false);
            context.router.replace(NamedRoute('Home'));
          },
          smsCodeSent: (_) {
            _addLoading(false);
            _addSmsCodeSent(true);
          },
          error: (error) {
            _addLoading(false);
            _addSmsCodeSent(false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.message)));
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).appGradient.background,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: WindowSizeScope.of(context).maybeMap(
                orElse: () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 48,
                  ),
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UiText.displayLarge('Dorm Fix'),
                        const SizedBox(height: 92),
                        SignInForm(
                          emailFocusNode: _emailFocusNode,
                          phoneFocusNode: _phoneFocusNode,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          phoneController: _phoneController,
                          pinCodeController: _pinCodeController,
                        ),
                        const SizedBox(height: 32),
                        AuthButton(
                          signInWithEmailAndPassword: () =>
                              _signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text,
                              ),
                          signInWithPhoneNumber: () =>
                              _signInWithPhoneNumber(_pinCodeController.text),
                          verifyPhoneNumber: () =>
                              _verifyPhoneNumber(_phoneController.text),
                        ),
                        const SizedBox(height: 32),
                        const AuthWithSocial(),
                      ],
                    ),
                  ),
                ),
                large: (_) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 176,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: UiText.displayLarge(
                          'Dorm Fix',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          width: 400,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SignInForm(
                                emailFocusNode: _emailFocusNode,
                                phoneFocusNode: _phoneFocusNode,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                phoneController: _phoneController,
                                pinCodeController: _pinCodeController,
                              ),
                              const SizedBox(height: 32),
                              AuthButton(
                                signInWithEmailAndPassword: () =>
                                    _signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text,
                                    ),
                                signInWithPhoneNumber: () =>
                                    _signInWithPhoneNumber(
                                      _pinCodeController.text,
                                    ),
                                verifyPhoneNumber: () =>
                                    _verifyPhoneNumber(_phoneController.text),
                              ),
                              const SizedBox(height: 32),
                              const AuthWithSocial(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
