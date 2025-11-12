import 'package:ui_kit/ui.dart';

sealed class UiCard extends StatelessWidget {
  const UiCard({
    super.key,
    required this.child,
    this.color,
    this.gradient,
    this.padding,
  });

  const factory UiCard.standart({
    Color? color,
    Gradient? gradient,
    EdgeInsets? padding,
    required Widget child,
  }) = UiCardStandart;

  const factory UiCard.clickable({
    Color? color,
    Gradient? gradient,
    EdgeInsets? padding,
    required Widget child,
    required Function() onTap,
  }) = UiCardClickable;

  final Color? color;
  final Gradient? gradient;
  final EdgeInsets? padding;
  final Widget child;

  T map<T>({
    required T Function(UiCardStandart) standart,
    required T Function(UiCardClickable) clickable,
  }) => switch (this) {
    final UiCardStandart card => standart(card),
    final UiCardClickable card => clickable(card),
  };

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return map(
      standart: (variant) => DecoratedBox(
        decoration: BoxDecoration(
          color: variant.color ?? Theme.of(context).colorPalette.secondary,
          borderRadius: BorderRadius.circular(24),
          gradient: variant.gradient,
        ),
        child: Padding(
          padding: variant.padding ?? AppPadding.allLarge,
          child: variant.child,
        ),
      ),
      clickable: (variant) => Ink(
        decoration: BoxDecoration(
          color: variant.color ?? Theme.of(context).colorPalette.secondary,
          borderRadius: BorderRadius.circular(24),
          gradient: variant.gradient,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: variant.onTap,
          overlayColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            final color = colorPalette.primaryForeground;
            if (states.contains(WidgetState.pressed)) {
              return color.withValues(alpha: 0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return color.withValues(alpha: 0.1);
            }
            if (states.contains(WidgetState.focused)) {
              return color.withValues(alpha: 0);
            }
            return null;
          }),
          child: Padding(
            padding: variant.padding ?? AppPadding.allLarge,
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
    required super.child,
    super.color,
    super.gradient,
    super.padding,
  });
}

class UiCardClickable extends UiCard {
  const UiCardClickable({
    super.key,
    required super.child,
    super.color,
    super.gradient,
    super.padding,
    required this.onTap,
  });

  final Function() onTap;
}
