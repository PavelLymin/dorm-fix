import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';
import 'bottom_navigation.dart';

part 'sidebar_navigation.dart';

class AppPage {
  const AppPage({
    required this.name,
    required this.title,
    required this.icon,
    required this.activeIcon,
  });

  final String name;
  final String title;
  final IconData icon;
  final IconData activeIcon;

  static const List<AppPage> pages = <AppPage>[
    AppPage(
      name: 'Home',
      title: 'Домашняя',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    AppPage(
      name: 'Request',
      title: 'Заявка',
      icon: Icons.request_page_outlined,
      activeIcon: Icons.request_page,
    ),
    AppPage(
      name: 'Profile',
      title: 'Профиль',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final window = WindowSizeScope.of(context);
    return AutoTabsRouter(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      lazyLoad: true,
      homeIndex: 0,
      routes: List.generate(
        AppPage.pages.length,
        (index) => NamedRoute(AppPage.pages[index].name),
      ),
      builder: (context, child) => Scaffold(
        bottomNavigationBar: window.mapOrNull(
          compact: (_) => const BottomNavigation(),
        ),
        drawer: Drawer(child: MenuNavigation()),
        body: window.maybeMap(
          compact: (_) => child,
          medium: (_) => Burger(child: child),
          orElse: () => SidebarNavigation(child: child),
        ),
      ),
    );
  }
}
