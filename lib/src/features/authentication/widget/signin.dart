import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:dorm_fix/src/features/authentication/widget/signin_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../home/widget/home.dart';
import '../state_management/auth_button/auth_button_bloc.dart';
import '../state_management/authentication/authentication_bloc.dart';
import 'signin_social.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  bool _isSmsCode = false;
  late AuthButtonBloc _authButtonBloc;

  @override
  void initState() {
    super.initState();
    _authButtonBloc = DependeciesScope.of(context).authButton;
  }

  void _addLoading(bool state) {
    if (!_isLoading && state) {
      _authButtonBloc.add(AuthButtonEvent.changeState(isLoading: true));
      _isLoading = true;
    } else if (_isLoading && !state) {
      _authButtonBloc.add(AuthButtonEvent.changeState(isLoading: false));
      _isLoading = false;
    }
  }

  void _addSmsCodeSent(bool state) {
    if (!_isSmsCode && state) {
      _authButtonBloc.add(AuthButtonEvent.changeState(isCodeSent: true));
      _isSmsCode = true;
    } else if (_isSmsCode && !state) {
      _authButtonBloc.add(AuthButtonEvent.changeState(isCodeSent: false));
      _isSmsCode = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: WindowSizeScope.of(context).maybeMap(
              orElse: () => Padding(
                padding: AppPadding.symmetricIncrement(
                  vertical: 6,
                  horizontal: 2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UiText.displayLarge(
                      'Dorm Fix',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 96),
                    const SignInForm(),
                    const SizedBox(height: 32),
                    const AuthWithSocial(),
                  ],
                ),
              ),
              large: (_) => Padding(
                padding: AppPadding.symmetricIncrement(
                  horizontal: 6,
                  vertical: 22,
                ), // const EdgeInsets.symmetric(
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
                      padding: AppPadding.symmetricIncrement(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SignInForm(),
                          const SizedBox(height: 32),
                          const SizedBox(height: 32),
                          const AuthWithSocial(),
                        ],
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
