import 'package:auto_route/auto_route.dart';

import '../../features/authentication/authentication.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/request/request.dart';
import '../../features/root/widget/root_screen.dart';
import '../../features/yandex_mapkit/widget/map_with_dormitories.dart';

class AppRouter extends RootStackRouter {
  @override
  List<NamedRouteDef> get routes => [
    NamedRouteDef(
      name: 'SignIn',
      initial: true,
      builder: (context, data) => const SignInScreen(),
    ),
    NamedRouteDef(
      name: 'Map',
      builder: (context, data) => MapWithDormitories(),
    ),
    NamedRouteDef(
      name: 'UpdatePhonScreen',
      builder: (context, data) => const UpdatePhoneScreen(),
    ),

    NamedRouteDef(
      name: 'Root',
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
