import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/src/error_util.dart';
import '../../authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void transition(BuildContext context, AuthState state) {
    return state.mapOrNull(
      error: (state) => ErrorUtil.showSnackBar(context, state.message),
      authenticated: (state) => state.authUser.mapAuthUser(
        firebase: (u) => context.router.replace(
          NamedRoute('MapScreen', params: {'user': u}),
        ),
        profile: (user) => user.mapRoleUser(
          student: (_) =>
              context.router.replace(const NamedRoute('StudentRootScreen')),
          master: (m) => context.router.replace(
            NamedRoute(
              'MasterRootScreen',
              params: {
                'spec_id': m.specialization.id,
                'dorm_id': m.dormitory.id,
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: transition,
    child: Scaffold(body: const Center(child: Text('Splash Screen'))),
  );
}
