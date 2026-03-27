import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/utils.dart';
import '../../authentication.dart';
import 'signin_form.dart';
import 'signin_social.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthButtonBloc _authButtonBloc;

  bool _isLoading = false;
  bool _isSmsCode = false;

  @override
  void initState() {
    super.initState();
    _authButtonBloc = AuthButtonBloc();
  }

  @override
  void dispose() {
    _authButtonBloc.close();
    super.dispose();
  }

  void _addLoading(bool state) {
    if (!_isLoading && state) {
      _authButtonBloc.add(.changeState(isLoading: true));
      _isLoading = true;
    } else if (_isLoading && !state) {
      _authButtonBloc.add(.changeState(isLoading: false));
      _isLoading = false;
    }
  }

  void _addSmsCodeSent(bool state) {
    if (!_isSmsCode && state) {
      _authButtonBloc.add(.changeState(isCodeSent: true));
      _isSmsCode = true;
    } else if (_isSmsCode && !state) {
      _authButtonBloc.add(.changeState(isCodeSent: false));
      _isSmsCode = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appPading = context.appStyle.appPadding;
    return BlocProvider.value(
      value: _authButtonBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (!state.isLoading) _addLoading(false);
          if (!state.isSmsCodeSent) _addSmsCodeSent(false);
          state.mapOrNull(
            loading: (_) => _addLoading(true),
            authenticated: (state) => state.authUser.mapAuthUser(
              firebase: (_) =>
                  context.router.replace(const NamedRoute('MapScreen')),
              profile: (user) => user.mapRoleUser(
                student: (_) => context.router.replace(
                  const NamedRoute('StudentRootSreen'),
                ),
                master: (m) =>
                    context.router.replace(const NamedRoute('MasterRootSreen')),
              ),
            ),
            smsCodeSent: (_) => _addSmsCodeSent(true),
            error: (state) => ErrorUtil.showSnackBar(context, state.message),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: UiText.displayLarge(
              'Dorm Fix',
              style: TextStyle(fontWeight: .w900),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SafeArea(
              child: Padding(
                padding: appPading.pagePadding,
                child: SingleChildScrollView(
                  padding: .only(top: 128.0),
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    mainAxisSize: .min,
                    spacing: 16.0,
                    children: [
                      UiText.titleLarge('Начните использовать приложение'),
                      const SignInForm(),
                      const AuthWithSocial(),
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
}
