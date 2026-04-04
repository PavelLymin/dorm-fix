import 'package:ui_kit/ui.dart';

const defaultAppStyle = AppStyle(
  borderRadius: .all(.circular(20.0)),
  cardBorderRadius: .all(.circular(24.0)),
  inputBorderRadius: .all(.circular(16.0)),
  lineCalendarStyle: LineCalendarStyle(),
  groupedListStyle: GroupedListStyle(),
);

class AppStyle extends ThemeExtension<AppStyle> {
  const AppStyle({
    required this.borderRadius,
    required this.cardBorderRadius,
    required this.inputBorderRadius,
    required this.lineCalendarStyle,
    required this.groupedListStyle,
  });

  final BorderRadius borderRadius;
  final BorderRadius cardBorderRadius;
  final BorderRadius inputBorderRadius;
  final LineCalendarStyle lineCalendarStyle;
  final GroupedListStyle groupedListStyle;

  @override
  ThemeExtension<AppStyle> copyWith({
    BorderRadius? borderRadius,
    BorderRadius? cardBorderRadius,
    BorderRadius? inputBorderRadius,
    LineCalendarStyle? lineCalendarStyle,
    GroupedListStyle? groupedListStyle,
  }) => AppStyle(
    borderRadius: borderRadius ?? this.borderRadius,
    cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    inputBorderRadius: inputBorderRadius ?? this.inputBorderRadius,
    lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
    groupedListStyle: groupedListStyle ?? this.groupedListStyle,
  );

  @override
  ThemeExtension<AppStyle> lerp(
    covariant ThemeExtension<AppStyle>? other,
    double t,
  ) => this;
}
