import 'package:ui_kit/ui.dart';

sealed class UiCard extends StatelessWidget {
  const UiCard({
    super.key,
    this.child,
    this.color,
    this.gradient,
    this.padding,
    this.borderRadius = const .all(.circular(32.0)),
  });

  const factory UiCard.standart({
    Color? color,
    Gradient? gradient,
    EdgeInsets? padding,
    BorderRadiusGeometry borderRadius,
    Widget? child,
  }) = UiCardStandart;

  const factory UiCard.clickable({
    Color? color,
    Gradient? gradient,
    EdgeInsets? padding,
    BorderRadiusGeometry borderRadius,
    Widget? child,
    ValueWidgetBuilder<Set<WidgetState>> builder,
    Function()? onTap,
    bool isSelected,
    bool autofocus,
    Color? selectedColor,
    Color? disabledColor,
  }) = UiCardClickable;

  final Color? color;
  final Gradient? gradient;
  final EdgeInsets? padding;
  final BorderRadiusGeometry borderRadius;
  final Widget? child;

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
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return map(
      standart: (variant) => DecoratedBox(
        decoration: BoxDecoration(
          color: variant.color ?? palette.card,
          borderRadius: variant.borderRadius,
          border: .all(color: palette.border, width: style.borderWidth),
          gradient: variant.gradient,
        ),
        child: Padding(
          padding: variant.padding ?? AppPadding.allLarge,
          child: variant.child,
        ),
      ),
      clickable: (variant) => GestureDetector(
        onTap: variant.onTap,
        child: WidgetStateBuilder(
          isSelected: variant.isSelected,
          isDisabled: variant.isDisabled,
          autofocus: variant.autofocus,
          builder: (context, states, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: AppWidgetStateMap({
                WidgetState.disabled: variant.disabledColor ?? palette.muted,
                WidgetState.selected:
                    variant.selectedColor ?? palette.secondary,
                WidgetState.any: variant.color ?? palette.card,
              }).resolve(states),
              borderRadius: variant.borderRadius,
              border: .all(color: palette.border, width: style.borderWidth),
              gradient: variant.gradient,
            ),
            child: Padding(
              padding: variant.padding ?? AppPadding.allLarge,
              child: variant.builder(context, states, variant.child),
            ),
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
    super.gradient,
    super.padding,
    super.borderRadius,
  });
}

class UiCardClickable extends UiCard {
  const UiCardClickable({
    super.key,
    super.child,
    super.color,
    super.gradient,
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
