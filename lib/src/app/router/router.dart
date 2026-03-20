import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';
import '../../features/authentication/authentication.dart';
import '../../features/authentication/src/widget/splash_screen.dart';
import '../../features/master/home/home.dart';
import '../../features/students/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/repair_request/request.dart';
import '../../features/root/widget/root_screen.dart';
import '../../features/students/repair_requests/repair_requests.dart';
import '../../features/yandex_mapkit/yandex_mapkit.dart';

class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: 'SplashScreen',
      builder: (_, _) => const SplashScreen(),
    ),
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
      name: 'PersonalDataScreen',
      builder: (context, data) => PersonalDataScreen(
        dormitoryId: data.params.getInt('dormitoryId'),
        roomId: data.params.getInt('roomId'),
      ),
    ),
    NamedRouteDef(
      name: 'FormRequestScreen',
      builder: (context, data) => const FormRequestScreen(),
    ),
    NamedRouteDef(
      name: 'HistoryScreen',
      builder: (context, data) => const HistoryScreen(),
    ),
    NamedRouteDef(
      name: 'StudentRootSreen',
      builder: (_, _) => const RootScreen(pages: studentPages),
      children: [
        NamedRouteDef(
          name: 'StudentHomeScreen',
          builder: (_, _) => const StudentHomeScreen(),
        ),
        NamedRouteDef(
          name: 'FormRequestScreen',
          builder: (_, _) => const FormRequestScreen(),
        ),
        NamedRouteDef(
          name: 'ProfileScreen',
          builder: (_, _) => const ProfileScreen(),
        ),
      ],
    ),
    NamedRouteDef(
      initial: true,

      name: 'MasterRootSreen',
      builder: (_, data) => const RootScreen(pages: masterPages),
      children: [
        NamedRouteDef(
          name: 'MasterHomeScreen',
          builder: (_, _) => const MasterHomeScreen(),
        ),
        NamedRouteDef(
          name: 'ProfileScreen',
          builder: (_, _) => const ProfileScreen(),
        ),
      ],
    ),
  ];
}

const List<AppPage> studentPages = <AppPage>[
  AppPage(
    name: 'StudentHomeScreen',
    title: 'Домашняя',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  AppPage(
    name: 'FormRequestScreen',
    title: 'Заявка',
    icon: Icons.request_page_outlined,
    activeIcon: Icons.request_page,
  ),
  AppPage(
    name: 'ProfileScreen',
    title: 'Профиль',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];

const List<AppPage> masterPages = <AppPage>[
  AppPage(
    name: 'MasterHomeScreen',
    title: 'Домашняя',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  AppPage(
    name: 'ProfileScreen',
    title: 'Профиль',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];
