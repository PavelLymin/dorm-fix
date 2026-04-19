import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/utils.dart';
import '../../authentication.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void transition(BuildContext context, AuthState state) => state.mapOrNull(
    error: (state) => ErrorUtil.showSnackBar(context, state.message),
    authenticated: (state) => state.authUser.mapAuthUser(
      firebase: (_) => context.router.replace(const NamedRoute('Map')),
      profile: (user) => user.mapRoleUser(
        student: (_) =>
            context.router.replace(const NamedRoute('StudentRootSreen')),
        master: (m) => context.router.replace(
          NamedRoute(
            'MasterRootSreen',
            params: {'spec_id': m.specialization.id, 'dorm_id': m.dormitory.id},
          ),
        ),
      ),
    ),
    notAuthenticated: (_) => context.router.replace(const NamedRoute('SignIn')),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocListener<AuthBloc, AuthState>(
      listener: transition,
      child: const Center(child: Text('Splash Screen')),
    ),
  );
}
