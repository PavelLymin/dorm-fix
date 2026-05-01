import 'package:ui_kit/ui.dart';

const defaultAppStyle = AppStyle(
  borderRadius: .all(.circular(20.0)),
  cardBorderRadius: .all(.circular(24.0)),
  inputBorderRadius: .all(.circular(16.0)),
  iconSize: 24.0,
  lineCalendarStyle: LineCalendarStyle(),
);

class AppStyle extends ThemeExtension<AppStyle> {
  const AppStyle({
    required this.borderRadius,
    required this.cardBorderRadius,
    required this.inputBorderRadius,
    required this.iconSize,
    required this.lineCalendarStyle,
  });

  final BorderRadius borderRadius;
  final BorderRadius cardBorderRadius;
  final BorderRadius inputBorderRadius;
  final double iconSize;
  final LineCalendarStyle lineCalendarStyle;

  @override
  ThemeExtension<AppStyle> copyWith({
    BorderRadius? borderRadius,
    BorderRadius? cardBorderRadius,
    BorderRadius? inputBorderRadius,
    double? iconSize,
    LineCalendarStyle? lineCalendarStyle,
  }) => AppStyle(
    borderRadius: borderRadius ?? this.borderRadius,
    cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    inputBorderRadius: inputBorderRadius ?? this.inputBorderRadius,
    iconSize: iconSize ?? this.iconSize,
    lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
  );

  @override
  ThemeExtension<AppStyle> lerp(
    covariant ThemeExtension<AppStyle>? other,
    double t,
  ) => this;
}
