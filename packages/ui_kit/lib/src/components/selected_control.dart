import '../../ui.dart';

class SlectedItem<T extends Object> {
  const SlectedItem({required this.value, required this.title, this.icon});

  final T value;
  final String title;
  final Icon? icon;
}

class UiSelectedControl<T extends Object> extends StatefulWidget {
  const UiSelectedControl({
    super.key,
    required this.options,
    required this.initial,
    required this.onChange,
    this.style = const SelectedControlStyle(),
  });

  final List<SlectedItem<T>> options;
  final T initial;
  final void Function(T) onChange;
  final SelectedControlStyle style;

  @override
  State<UiSelectedControl<T>> createState() => _UiSelectedControlState<T>();
}

class _UiSelectedControlState<T extends Object>
    extends State<UiSelectedControl<T>> {
  late int _initial;

  @override
  void initState() {
    super.initState();
    _initialIndex();
  }

  @override
  void didUpdateWidget(covariant UiSelectedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial != oldWidget.initial) _initialIndex();
  }

  int _initialIndex() => _initial = widget.options.indexWhere(
    (item) => item.value == widget.initial,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final style = theme.appStyle;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.style.barColor ?? palette.background,
        borderRadius: widget.style.borderRadius ?? style.borderRadius,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final itemWidth = constraints.maxWidth / widget.options.length;
          return Stack(
            alignment: .center,
            children: [
              AnimatedPositioned(
                duration: widget.style.duration,
                curve: widget.style.curve,
                left: itemWidth * _initial,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.style.indicatorColor ?? palette.primary,
                    borderRadius:
                        widget.style.borderRadius ?? style.borderRadius,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                mainAxisSize: .min,
                children: List.generate(
                  widget.options.length,
                  (index) => SizedBox(
                    width: itemWidth,
                    child: _ButtonItemOption<T>(
                      item: widget.options[index],
                      onChange: widget.onChange,
                      indicator: index == _initial,
                      style: widget.style,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SelectedControlStyle {
  const SelectedControlStyle({
    this.barColor,
    this.indicatorColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.indicatorTextStyle,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final Color? barColor;
  final Color? indicatorColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? indicatorTextStyle;
  final Duration duration;
  final Curve curve;
}

class _ButtonItemOption<T extends Object> extends StatelessWidget {
  const _ButtonItemOption({
    super.key,
    required this.item,
    required this.onChange,
    required this.indicator,
    required this.style,
  });

  final SlectedItem<T> item;
  final void Function(T) onChange;
  final bool indicator;
  final SelectedControlStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => onChange(item.value),
      child: Padding(
        padding: AppInsets.card,
        child: Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: 8.0,
          children: [
            if (item.icon != null) item.icon!,
            Flexible(
              child: UiText2.m(
                item.title,
                overflow: .ellipsis,
                style: indicator ? style.indicatorTextStyle : style.textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
