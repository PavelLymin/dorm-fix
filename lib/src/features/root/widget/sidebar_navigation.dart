part of 'root_screen.dart';

class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ColoredBox(
            color: Theme.of(context).colorPalette.secondary,
            child: Padding(
              padding: AppPadding.onlyIncrement(top: 16),
              child: ListView(
                children: List.generate(AppPage.pages.length, (index) {
                  final page = AppPage.pages[index];
                  return _TabItem(
                    index: index,
                    title: page.title,
                    icon: page.icon,
                    activeIcon: page.activeIcon,
                  );
                }),
              ),
            ),
          ),
        ),
        Expanded(flex: 3, child: child),
      ],
    ),
  );
}

class MenuNavigation extends StatelessWidget {
  const MenuNavigation({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Theme.of(context).colorPalette.secondary,
    child: Padding(
      padding: AppPadding.onlyIncrement(top: 16),
      child: ListView(
        children: List.generate(AppPage.pages.length, (index) {
          final page = AppPage.pages[index];
          return _TabItem(
            index: index,
            title: page.title,
            icon: page.icon,
            activeIcon: page.activeIcon,
          );
        }),
      ),
    ),
  );
}

class _TabItem extends StatefulWidget {
  const _TabItem({
    required this.index,
    required this.title,
    required this.icon,
    required this.activeIcon,
  });

  final int index;
  final String title;
  final IconData icon;
  final IconData activeIcon;

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _isActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isActive =
        AutoTabsRouter.of(context, watch: true).activeIndex == widget.index;
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: AppPadding.symmetricIncrement(horizontal: 3),
    child: GestureDetector(
      onTap: () => AutoTabsRouter.of(context).setActiveIndex(widget.index),
      child: DecoratedBox(
        decoration: _isActive
            ? BoxDecoration(
                color: Theme.of(context).colorPalette.secondary,
                borderRadius: BorderRadius.circular(16),
              )
            : BoxDecoration(),
        child: Padding(
          padding: AppPadding.allMedium,
          child: Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_isActive ? widget.activeIcon : widget.icon),
              Text(widget.title),
            ],
          ),
        ),
      ),
    ),
  );
}

class Burger extends StatelessWidget {
  const Burger({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ColoredBox(
        color: Theme.of(context).colorPalette.secondary,
        child: Column(
          children: [
            Padding(
              padding: AppPadding.symmetricIncrement(
                horizontal: 2,
                vertical: 7,
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, size: 32),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ],
        ),
      ),
      Expanded(child: child),
    ],
  );
}
