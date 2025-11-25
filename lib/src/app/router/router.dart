import 'package:auto_route/auto_route.dart';
import '../../features/authentication/widget/signin.dart';
import '../../features/home/widget/home.dart';
import '../../features/profile/widget/profile_screen.dart';
import '../../features/request/widget/request_screen.dart';
import '../../features/root/widget/root_screen.dart';

class AppRouter extends RootStackRouter {
  @override
  List<NamedRouteDef> get routes => [
    NamedRouteDef(
      name: 'SignIn',
      initial: true,
      builder: (context, data) => SignInScreen(),
    ),
    // NamedRouteDef(name: 'Map', builder: (context, data) => MapWithDormPins()),
    NamedRouteDef(
      name: 'Root',
      builder: (_, _) => const RootScreen(),
      children: [
        NamedRouteDef(
          name: 'Home',
          initial: false,
          builder: (_, _) => const HomeScreen(),
        ),
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
