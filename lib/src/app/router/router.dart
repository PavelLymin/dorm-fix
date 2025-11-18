import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/authentication/widget/signin.dart';
import 'package:dorm_fix/src/features/yandex_map/widget/map_with_dorm_pins.dart';
import '../../features/home/widget/home.dart';

class AppRouter extends RootStackRouter {
  @override
  List<NamedRouteDef> get routes => [
    NamedRouteDef(
      name: 'Home',
      builder: (context, data) {
        return Home();
      },
    ),
    NamedRouteDef(
      name: 'SignInRoute',
      builder: (context, data) {
        return SignIn();
      },
    ),
    NamedRouteDef(
      name: 'MapRoute',
      initial: true,
      builder: (context, data) {
        return MapWithDormPins();
      },
    ),
  ];
}
