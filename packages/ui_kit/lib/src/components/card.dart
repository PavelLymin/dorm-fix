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
    final colorPalette = context.palette;
    final style = context.appStyle.style;
    return map(
      standart: (variant) => DecoratedBox(
        decoration: BoxDecoration(
          color: variant.color ?? colorPalette.card,
          borderRadius: const .all(.circular(24.0)),
          border: .all(color: colorPalette.border, width: style.borderWidth),
          gradient: variant.gradient,
        ),
        child: Padding(
          padding: variant.padding ?? AppPadding.allLarge,
          child: variant.child,
        ),
      ),
      clickable: (variant) => Ink(
        decoration: BoxDecoration(
          color: variant.color ?? Theme.of(context).colorPalette.card,
          borderRadius: const .all(.circular(24)),
          gradient: variant.gradient,
        ),
        child: InkWell(
          borderRadius: const .all(.circular(24)),
          onTap: variant.onTap,
          overlayColor: .resolveWith((Set<WidgetState> states) {
            final color = colorPalette.card;
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

class ClickableCard extends StatefulWidget {
  const ClickableCard({
    super.key,
    this.isSelected = false,
    this.autofocus = false,
    this.onPress,
    this.child,
    this.builder = _builder,
  });

  static Widget _builder(
    BuildContext context,
    Set<WidgetState> states,
    Widget? child,
  ) => child!;

  final bool isSelected;
  final bool autofocus;
  final VoidCallback? onPress;
  final Widget? child;
  final ValueWidgetBuilder<Set<WidgetState>> builder;

  bool get isDisabled => onPress == null;

  @override
  State<ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: WidgetStateBuilder(
        isSelected: widget.isSelected,
        autofocus: widget.autofocus,
        builder: widget.builder,
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
