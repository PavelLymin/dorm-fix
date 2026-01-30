import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../authentication.dart';
import 'signin_form.dart';
import 'signin_social.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  bool _isSmsCode = false;
  final _authButtonBloc = AuthButtonBloc();

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
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => _authButtonBloc,
    child: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.isLoading) _addLoading(false);
        if (!state.isSmsCodeSent) _addSmsCodeSent(false);
        state.mapOrNull(
          loading: (_) => _addLoading(true),
          signedUp: (_) => context.router.replace(const NamedRoute('Map')),
          loggedIn: (_) => context.router.replace(const NamedRoute('Home')),
          smsCodeSent: (_) => _addSmsCodeSent(true),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: WindowSizeScope.of(context).maybeMap(
              orElse: () => Padding(
                padding: AppPadding.symmetricIncrement(
                  vertical: 6,
                  horizontal: 2,
                ),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        UiText.displayLarge(
                          'Dorm Fix',
                          style: TextStyle(fontWeight: .w900),
                        ),
                        const SizedBox(height: 96),
                        const SignInForm(),
                        const SizedBox(height: 32),
                        const AuthWithSocial(),
                      ],
                    ),
                  ),
                ),
              ),
              large: (_) => Padding(
                padding: AppPadding.symmetricIncrement(
                  horizontal: 6,
                  vertical: 22,
                ),
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    const Spacer(),
                    UiText.displayLarge(
                      'Dorm Fix',
                      style: TextStyle(fontWeight: .w900),
                    ),
                    const Spacer(),
                    Padding(
                      padding: AppPadding.symmetricIncrement(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            const SignInForm(),
                            const SizedBox(height: 32),
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
