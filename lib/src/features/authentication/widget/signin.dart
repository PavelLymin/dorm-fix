import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/model/application_config.dart';
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
  bool _isValidateEmail = false;
  bool _isValidatePassword = false;
  bool _isValidatePhone = false;
  bool _isLoading = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _onEmailChanged();
    _onPasswordChanged();
    _onPhoneChanged();
    _onLoading();
  }

  void _onEmailChanged() {
    _emailController.addListener(() {
      if (_validateEmail(_emailController.text) && !_isValidateEmail) {
        setState(() {
          _isValidateEmail = true;
        });
      } else if (!_validateEmail(_emailController.text) && _isValidateEmail) {
        setState(() {
          _isValidateEmail = false;
        });
      }
    });
  }

  void _onPasswordChanged() {
    _passwordController.addListener(() {
      if (_validatePassword(_passwordController.text) && !_isValidatePassword) {
        setState(() {
          _isValidatePassword = true;
        });
      } else if (!_validatePassword(_passwordController.text) &&
          _isValidatePassword) {
        setState(() {
          _isValidatePassword = false;
        });
      }
    });
  }

  void _onPhoneChanged() {
    _phoneController.addListener(() {
      if (_validatePhoneNumber(_phoneController.text) && !_isValidatePhone) {
        setState(() {
          _isValidatePhone = true;
        });
      } else if (!_validatePhoneNumber(_phoneController.text) &&
          _isValidatePhone) {
        setState(() {
          _isValidatePhone = false;
        });
      }
    });
  }

  void _onLoading() {
    _subscription = context.read<AuthBloc>().stream.listen((state) {
      setState(() {
        state.isLoading ? _isLoading = true : _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          authenticated: (_) => context.router.replace(NamedRoute('Home')),
          error: (error) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.message))),
        );
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: WindowSize.fromSize(MediaQuery.sizeOf(context)).maybeMap(
              compact: (_) => Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        width: double.infinity,
                        height: 128,
                        'packages/ui_kit/assets/icons/microsoft.png',
                      ),
                      const SizedBox(height: 32),
                      SignInForm(
                        emailFocusNode: _emailFocusNode,
                        phoneFocusNode: _phoneFocusNode,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        phoneController: _phoneController,
                      ),
                      const SizedBox(height: 32),
                      AuthButton(
                        isEnable:
                            (_isValidateEmail & _isValidatePassword ||
                                _isValidatePhone) &
                            !_isLoading,
                        onPressed: () => _signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const AuthWithSocial(),
                    ],
                  ),
                ),
              ),
              orElse: () => Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        width: double.infinity,
                        height: 256,
                        'packages/ui_kit/assets/icons/microsoft.png',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            SignInForm(
                              emailFocusNode: _emailFocusNode,
                              phoneFocusNode: _phoneFocusNode,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              phoneController: _phoneController,
                            ),
                            const SizedBox(height: 32),
                            AuthButton(
                              isEnable:
                                  (_isValidateEmail & _isValidatePassword ||
                                      _isValidatePhone) &
                                  !_isLoading,
                              onPressed: () => _signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text,
                              ),
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
  );
}
