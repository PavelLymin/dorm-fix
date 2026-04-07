import 'package:ui_kit/ui.dart';

class TileGroupStyle {
  TileGroupStyle({
    this.iconSize,
    this.selectedColor,
    this.padding,
    this.borderRadius,
    this.titleStyle,
    this.subtitleStyle,
    this.buttonStyle,
  });

  final double? iconSize;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final ButtonStyle? buttonStyle;

  TileGroupStyle copyWith({
    Color? selectedColor,
    EdgeInsets? padding,
    double? iconSize,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    ButtonStyle? buttonStyle,
  }) => TileGroupStyle(
    selectedColor: selectedColor ?? this.selectedColor,
    padding: padding ?? this.padding,
    iconSize: iconSize ?? this.iconSize,
    borderRadius: borderRadius ?? this.borderRadius,
    titleStyle: titleStyle ?? this.titleStyle,
    subtitleStyle: subtitleStyle ?? this.subtitleStyle,
    buttonStyle: buttonStyle ?? this.buttonStyle,
  );
}

abstract class ItemStyle {
  ItemStyle();

  static TileGroupStyle initStyle(
    BuildContext context,
    TileGroupStyle? style,
    bool isFirst,
    bool isLast,
  ) {
    final padding = EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: isFirst ? 12.0 : 6.0,
      bottom: isLast ? 12.0 : 6.0,
    );
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return TileGroupStyle(
      iconSize: 24.0,
      borderRadius: .all(.circular(24.0)),
      padding: padding,
      buttonStyle: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(.zero),
        elevation: const WidgetStatePropertyAll(.0),
        iconSize: const WidgetStatePropertyAll(24.0),
        padding: .all(padding),
        shape: .all(
          RoundedRectangleBorder(
            borderRadius: .vertical(
              top: isFirst ? .circular(20.0) : .zero,
              bottom: isLast ? .circular(20.0) : .zero,
            ),
          ),
        ),
        iconColor: AppWidgetStateMap<Color>({
          WidgetState.disabled: palette.disabledIcon,
          WidgetState.any: palette.foreground,
        }),
        tapTargetSize: .shrinkWrap,
        overlayColor: AppWidgetStateMap<Color>({
          WidgetState.selected: palette.foreground.withValues(alpha: .2),
          WidgetState.disabled: palette.disabled.withValues(alpha: .1),
          WidgetState.any: palette.foreground.withValues(alpha: .1),
        }),
        backgroundColor: AppWidgetStateMap<Color>({
          WidgetState.selected: palette.secondary,
          WidgetState.disabled: palette.disabled,
          WidgetState.any: palette.card,
        }),
      ).merge(style?.buttonStyle),
    ).copyWith(
      selectedColor: style?.selectedColor,
      borderRadius: style?.borderRadius,
      titleStyle: style?.titleStyle,
      subtitleStyle: style?.subtitleStyle,
    );
  }
}
