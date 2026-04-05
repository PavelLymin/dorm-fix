import 'package:ui_kit/ui.dart';

sealed class UiCard extends StatelessWidget {
  const UiCard({
    super.key,
    this.child,
    this.color,
    this.padding,
    this.borderRadius,
  });

  final Color? color;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? child;

  const factory UiCard.standart({
    Color? color,
    EdgeInsets? padding,
    BorderRadius borderRadius,
    Widget? child,
  }) = UiCardStandart;

  const factory UiCard.clickable({
    Color? color,
    EdgeInsets? padding,
    BorderRadius borderRadius,
    Widget? child,
    ValueWidgetBuilder<Set<WidgetState>> builder,
    Function()? onTap,
    bool isSelected,
    bool autofocus,
    Color? selectedColor,
    Color? disabledColor,
  }) = UiCardClickable;

  T map<T>({
    required T Function(UiCardStandart) standart,
    required T Function(UiCardClickable) clickable,
  }) => switch (this) {
    final UiCardStandart card => standart(card),
    final UiCardClickable card => clickable(card),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final style = theme.appStyle;
    return map(
      standart: (variant) => DecoratedBox(
        decoration: BoxDecoration(
          color: variant.color ?? palette.card,
          borderRadius: variant.borderRadius ?? style.cardBorderRadius,
        ),
        child: Padding(
          padding: variant.padding ?? AppInsets.card,
          child: variant.child,
        ),
      ),
      clickable: (variant) => GestureDetector(
        onTap: variant.onTap,
        child: WidgetStateBuilder(
          isSelected: variant.isSelected,
          isDisabled: variant.isDisabled,
          autofocus: variant.autofocus,
          builder: (context, states, child) {
            final color = AppWidgetStateMap({
              WidgetState.disabled: variant.disabledColor ?? palette.disabled,
              WidgetState.selected: variant.selectedColor ?? palette.secondary,
              WidgetState.any: variant.color ?? palette.card,
            }).resolve(states);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: color,
                borderRadius: variant.borderRadius ?? style.cardBorderRadius,
              ),
              child: variant.builder(context, states, child),
            );
          },
          child: Padding(
            padding: variant.padding ?? AppInsets.card,
            child: variant.child,
          ),
        ),
      ),
    );
  }
}

class UiCardStandart extends UiCard {
  const UiCardStandart({
    super.key,
    super.child,
    super.color,
    super.padding,
    super.borderRadius,
  });
}

class UiCardClickable extends UiCard {
  const UiCardClickable({
    super.key,
    super.child,
    super.color,
    super.padding,
    super.borderRadius,
    this.builder = _builder,
    this.isSelected = false,
    this.autofocus = false,
    this.onTap,
    this.selectedColor,
    this.disabledColor,
  });
  static Widget _builder(
    BuildContext context,
    Set<WidgetState> states,
    Widget? child,
  ) => child!;

  final Function()? onTap;
  final ValueWidgetBuilder<Set<WidgetState>> builder;
  final bool isSelected;
  final bool autofocus;
  final Color? selectedColor;
  final Color? disabledColor;

  bool get isDisabled => onTap == null;
}
