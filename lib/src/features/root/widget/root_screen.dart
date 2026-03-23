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
}

class MasterDataScope extends InheritedWidget {
  const MasterDataScope({
    super.key,
    required this.specializationId,
    required this.dormitoryId,
    required super.child,
  });

  final int specializationId;
  final int dormitoryId;

  static MasterDataScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MasterDataScope>();
    assert(scope != null, 'MasterDataScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(MasterDataScope oldWidget) {
    return specializationId != oldWidget.specializationId ||
        dormitoryId != oldWidget.dormitoryId;
  }
}

class MasterRootScreen extends StatelessWidget {
  const MasterRootScreen({
    super.key,
    required this.pages,
    required this.specializationId,
    required this.dormitoryId,
  });

  final List<AppPage> pages;
  final int specializationId;
  final int dormitoryId;

  @override
  Widget build(BuildContext context) => MasterDataScope(
    specializationId: specializationId,
    dormitoryId: dormitoryId,
    child: RootScreen(pages: pages),
  );
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  Widget build(BuildContext context) {
    final window = WindowSizeScope.of(context);
    return AutoTabsRouter(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      lazyLoad: true,
      homeIndex: 0,
      routes: List.generate(
        pages.length,
        (index) => NamedRoute(pages[index].name),
      ),
      builder: (context, child) => Scaffold(
        bottomNavigationBar: window.mapOrNull(
          compact: (_) => BottomNavigation(pages: pages),
        ),
        // drawer: Drawer(child: MenuNavigation()),
        body: window.maybeMap(
          compact: (_) => child,
          medium: (_) => Burger(child: child),
          orElse: () => SidebarNavigation(pages: pages, child: child),
        ),
      ),
    );
  }
}
