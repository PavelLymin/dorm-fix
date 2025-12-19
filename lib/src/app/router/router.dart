import 'package:auto_route/auto_route.dart';
import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/request/request.dart';
import '../../features/root/widget/root_screen.dart';
import '../../features/yandex_mapkit/yandex_mapkit.dart';

class AppRouter extends RootStackRouter {
  AppRouter({required AuthBloc authenticationBloc})
    : _authenticationBloc = authenticationBloc;

  final AuthBloc _authenticationBloc;

  @override
  List<NamedRouteDef> get routes => [
    NamedRouteDef(
      name: 'SignIn',
      builder: (context, data) => const SignInScreen(),
    ),
    NamedRouteDef(
      name: 'Map',
      builder: (context, data) => MapWithDormitories(),
    ),
    NamedRouteDef(
      name: 'UpdatePhoneScreen',
      builder: (context, data) => const UpdatePhoneScreen(),
    ),
    NamedRouteDef(
      name: 'ExtraPersonDataScreen',
      builder: (context, data) => PersonalDataScreen(
        dormitoryId: data.params.getInt('dormitoryId'),
        roomId: data.params.getInt('roomId'),
      ),
    ),
    NamedRouteDef(
      name: 'RequestScreen',
      builder: (context, data) => const RequestScreen(),
    ),
    NamedRouteDef(
      name: 'HistoryScreen',
      builder: (context, data) => const HistoryScreen(),
    ),
    NamedRouteDef(
      initial: true,
      name: 'Root',
      guards: [AuthGuard(authenticationBloc: _authenticationBloc)],
      builder: (_, _) => const RootScreen(),
      children: [
        NamedRouteDef(name: 'Home', builder: (_, _) => const HomeScreen()),
        NamedRouteDef(
          name: 'Request',
          builder: (_, _) => const RequestScreen(),
        ),
        NamedRouteDef(
          name: 'Profile',
          builder: (_, _) => const ProfileScreen(),
        ),
      ],
    ),
  ];
}

class AuthGuard extends AutoRouteGuard {
  const AuthGuard({required AuthBloc authenticationBloc})
    : _authenticationBloc = authenticationBloc;

  final AuthBloc _authenticationBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _authenticationBloc.state.isAuthenticated;
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.navigate(NamedRoute('SignIn'));
    }
  }
}
