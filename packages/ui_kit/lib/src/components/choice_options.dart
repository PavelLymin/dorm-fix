import 'package:ui_kit/ui.dart';

class ChoiceItem {
  const ChoiceItem({required this.title, this.icon});

  final String title;
  final Icon? icon;
}

class ChoiceOptions extends StatelessWidget {
  const ChoiceOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.onChange,
    required this.barColor,
    required this.selectedColor,
    this.borderRadius = const .all(.circular(16.0)),
    this.iconSize = 32,
    this.height = 48,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeIn,
  });

  final List<ChoiceItem> options;
  final int selected;
  final void Function(int) onChange;
  final Color barColor;
  final Color selectedColor;
  final BorderRadius borderRadius;
  final double iconSize;
  final double height;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: borderRadius,
        border: .all(
          color: colorPalette.border,
          width: context.appStyle.style.borderWidth,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: .center,
          children: [
            _SelectedItemOption(
              options: options,
              selected: selected,
              constraints: constraints,
              selectedColor: selectedColor,
              borderRadius: borderRadius,
              height: height,
              duration: duration,
              curve: curve,
            ),
            Row(
              mainAxisAlignment: .spaceAround,
              crossAxisAlignment: .center,
              children: List.generate(options.length, (index) {
                final option = options[index];
                return _ButtonItemOption(
                  item: option,
                  onChange: onChange,
                  index: index,
                  iconSize: iconSize,
                  height: height,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedItemOption extends StatefulWidget {
  const _SelectedItemOption({
    required this.options,
    required this.selected,
    required this.constraints,
    required this.selectedColor,
    required this.borderRadius,
    required this.height,
    required this.duration,
    required this.curve,
  });

  final List<ChoiceItem> options;
  final int selected;
  final BoxConstraints constraints;
  final Color selectedColor;
  final BorderRadius borderRadius;
  final double height;
  final Duration duration;
  final Curve curve;

  @override
  State<_SelectedItemOption> createState() => _SelectedItemOptionState();
}

class _SelectedItemOptionState extends State<_SelectedItemOption> {
  final double _padding = 4.0;
  late final BorderRadius _borderRadiusItem;

  @override
  void initState() {
    super.initState();
    _borderRadiusItem = widget.borderRadius - .all(.circular(_padding));
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    final itemWidth = widget.constraints.maxWidth / widget.options.length;

    return AnimatedPositioned(
      duration: widget.duration,
      curve: widget.curve,
      left: itemWidth * widget.selected,
      child: SizedBox(
        height: widget.height,
        width: itemWidth,
        child: Padding(
          padding: .all(_padding),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.selectedColor,
              borderRadius: _borderRadiusItem,
              border: .all(
                color: colorPalette.borderStrong,
                width: context.appStyle.style.borderWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonItemOption extends StatelessWidget {
  const _ButtonItemOption({
    required this.item,
    required this.onChange,
    required this.index,
    required this.iconSize,
    required this.height,
  });

  final ChoiceItem item;
  final void Function(int) onChange;
  final int index;
  final double iconSize;
  final double height;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: .opaque,
    onTap: () => onChange(index),
    child: SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          if (item.icon != null) item.icon!,
          if (item.icon != null) const SizedBox(width: 4.0),
          UiText.labelLarge(item.title, overflow: .ellipsis),
        ],
      ),
    ),
  );
}
