import 'package:ui_kit/ui.dart';

class ChoiceItem {
  const ChoiceItem({required this.title, this.icon});

  final String title;
  final IconData? icon;
}

class ChoiceOptions extends StatefulWidget {
  const ChoiceOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.barColor,
    required this.selectedColor,
    required this.onChange,
    this.height = 48,
    this.overflow = .ellipsis,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
    this.borderRadius = const .all(.circular(24)),
    this.iconSize = 32,
  });

  final List<ChoiceItem> options;
  final int selected;
  final Color barColor;
  final Color selectedColor;
  final void Function(int) onChange;
  final double height;
  final TextOverflow overflow;
  final Duration duration;
  final Curve curve;
  final BorderRadius borderRadius;
  final double iconSize;

  @override
  State<ChoiceOptions> createState() => _ChoiceOptionsState();
}

class _ChoiceOptionsState extends State<ChoiceOptions> {
  late final BorderRadius _borderRadiusItem;

  @override
  void initState() {
    super.initState();
    _borderRadiusItem = widget.borderRadius - const .all(.circular(4));
  }

  @override
  Widget build(BuildContext context) => Center(
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: widget.barColor,
        borderRadius: widget.borderRadius,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: .center,
          children: [
            AnimatedPositioned(
              duration: widget.duration,
              curve: widget.curve,
              left:
                  (constraints.maxWidth / widget.options.length) *
                  (widget.selected),
              child: SizedBox(
                height: widget.height,
                width: constraints.maxWidth / widget.options.length,
                child: Padding(
                  padding: const .all(4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widget.selectedColor,
                      borderRadius: _borderRadiusItem,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: .spaceAround,
              crossAxisAlignment: .center,
              children: List.generate(widget.options.length, (index) {
                final option = widget.options[index];
                return _ButtonItemOption(
                  item: option,
                  onChange: widget.onChange,
                  index: index,
                  height: widget.height,
                  borderRadiusItem: _borderRadiusItem,
                  overflow: widget.overflow,
                  iconSize: widget.iconSize,
                );
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ButtonItemOption extends StatelessWidget {
  const _ButtonItemOption({
    required this.item,
    required this.onChange,
    required this.index,
    required this.height,
    required this.borderRadiusItem,
    required this.overflow,
    required this.iconSize,
  });

  final ChoiceItem item;
  final void Function(int) onChange;
  final int index;
  final double height;
  final BorderRadius borderRadiusItem;
  final TextOverflow overflow;
  final double iconSize;

  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      behavior: .opaque,
      onTap: () => onChange(index),
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            item.icon != null
                ? Flexible(child: Icon(item.icon, size: iconSize))
                : const SizedBox.shrink(),
            const SizedBox(width: 4),
            Flexible(child: UiText.labelLarge(item.title, overflow: overflow)),
          ],
        ),
      ),
    ),
  );
}
