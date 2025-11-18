part of 'root_screen.dart';

class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Row(
      children: [
        NavigationRail(
          destinations: List.generate(AppPage.pages.length, (index) {
            final page = AppPage.pages[index];
            return NavigationRailDestination(
              icon: Icon(page.icon),
              selectedIcon: Icon(page.activeIcon),
              label: Text(page.name),
            );
          }),
          selectedIndex: AutoTabsRouter.of(context).activeIndex,
        ),
        Expanded(child: Center(child: child)),
      ],
    ),
  );
}
