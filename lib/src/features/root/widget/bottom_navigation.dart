import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/root/widget/root_screen.dart';
import 'package:ui_kit/ui.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        crossAxisAlignment: .center,
        children: List.generate(pages.length, (index) {
          final page = pages[index];
          return TabItem(
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

class TabItem extends StatefulWidget {
  const TabItem({
    super.key,
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
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  bool _isActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isActive =
        AutoTabsRouter.of(context, watch: true).activeIndex == widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return GestureDetector(
      onTap: () => AutoTabsRouter.of(context).setActiveIndex(widget.index),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Icon(
            _isActive ? widget.activeIcon : widget.icon,
            color: _isActive
                ? colorPalette.foreground
                : colorPalette.mutedForeground,
          ),
          UiText.bodySmall(
            widget.title,
            color: _isActive
                ? colorPalette.foreground
                : colorPalette.mutedForeground,
          ),
        ],
      ),
    );
  }
}
