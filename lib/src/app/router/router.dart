import 'package:auto_route/auto_route.dart';
import '../../features/authentication/widget/signin.dart';
import '../../features/home/widget/home.dart';
import '../../features/profile/widget/profile.dart';
import '../../features/request/widget/request_screen.dart';
import '../../features/root/widget/root_screen.dart';
import '../../features/yandex_map/widget/map_with_dorm_pins.dart';

class AppRouter extends RootStackRouter {
  @override
  List<NamedRouteDef> get routes => [
    NamedRouteDef(name: 'SignIn', builder: (context, data) => SignInScreen()),
    NamedRouteDef(name: 'Map', builder: (context, data) => MapWithDormPins()),
    NamedRouteDef(
      name: 'Root',
      initial: true,
      builder: (_, _) => const RootScreen(),
      children: [
        NamedRouteDef(
          name: 'Home',
          initial: true,
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
