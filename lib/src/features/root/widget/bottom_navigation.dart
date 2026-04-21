import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/root/widget/root_screen.dart';
import 'package:ui_kit/ui.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette2;
    return ColoredBox(
      color: palette.card,
      child: SafeArea(
        child: Padding(
          padding: const .only(top: 16.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            crossAxisAlignment: .start,
            children: List.generate(pages.length, (index) {
              final page = pages[index];
              return TabItem(index: index, title: page.title, icon: page.icon);
            }),
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatefulWidget {
  const TabItem({
    super.key,
    required this.index,
    required this.title,
    required this.icon,
  });

  final int index;
  final String title;
  final IconData icon;

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
    final palette = Theme.of(context).colorPalette2;
    return GestureDetector(
      onTap: () => AutoTabsRouter.of(context).setActiveIndex(widget.index),
      child: Icon(
        widget.icon,
        color: _isActive ? palette.primary : palette.secondary,
      ),
    );
  }
}
