import 'package:ui_kit/ui.dart';

class TileGroupStyle {
  TileGroupStyle({
    double? iconSize,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    this.selectedColor,
    this.titleStyle,
    this.subtitleStyle,
    this.buttonStyle,
  }) : iconSize = iconSize ?? 24.0,
       padding =
           padding ??
           const .only(left: 20.0, right: 20.0, top: 12.0, bottom: 12.0),
       borderRadius = borderRadius ?? const .all(.circular(20.0));

  final double? iconSize;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final ButtonStyle? buttonStyle;

  TileGroupStyle copyWith({
    Color? selectedColor,
    EdgeInsets? padding,
    double? iconSize,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    ButtonStyle? buttonStyle,
  }) => TileGroupStyle(
    selectedColor: selectedColor ?? this.selectedColor,
    padding: padding ?? this.padding,
    iconSize: iconSize ?? this.iconSize,
    borderRadius: borderRadius ?? this.borderRadius,
    titleStyle: this.titleStyle?.merge(titleStyle),
    subtitleStyle: this.subtitleStyle?.merge(subtitleStyle),
    buttonStyle: buttonStyle ?? this.buttonStyle,
  );

  factory TileGroupStyle.defaultStyle(
    BuildContext context,
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
        visualDensity: .standard,
        overlayColor: AppWidgetStateMap<Color>({
          WidgetState.selected: palette.foreground.withValues(alpha: .2),
          WidgetState.disabled: palette.disabled.withValues(alpha: .1),
          WidgetState.any: palette.foreground.withValues(alpha: .1),
        }),
        backgroundColor: AppWidgetStateMap<Color>({
          WidgetState.disabled: palette.disabled,
          WidgetState.any: palette.card,
        }),
      ),
    );
  }
}
