import 'package:ui_kit/ui.dart';

const defaultAppStyle = AppStyle(
  borderRadius: .all(.circular(24.0)),
  inputBorderRadius: .all(.circular(16.0)),
  appPadding: AppPadding(),
  lineCalendarStyle: LineCalendarStyle(),
  groupedListStyle: GroupedListStyle(),
);

class AppStyle extends ThemeExtension<AppStyle> {
  const AppStyle({
    required this.borderRadius,
    required this.inputBorderRadius,
    required this.appPadding,
    required this.lineCalendarStyle,
    required this.groupedListStyle,
  });

  final BorderRadius borderRadius;
  final BorderRadius inputBorderRadius;
  final AppPadding appPadding;
  final LineCalendarStyle lineCalendarStyle;
  final GroupedListStyle groupedListStyle;

  @override
  ThemeExtension<AppStyle> copyWith({
    BorderRadius? borderRadius,
    BorderRadius? inputBorderRadius,
    AppPadding? appPadding,
    LineCalendarStyle? lineCalendarStyle,
    GroupedListStyle? groupedListStyle,
  }) => AppStyle(
    borderRadius: borderRadius ?? this.borderRadius,
    inputBorderRadius: inputBorderRadius ?? this.inputBorderRadius,
    appPadding: appPadding ?? this.appPadding,
    lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
    groupedListStyle: groupedListStyle ?? this.groupedListStyle,
  );

  @override
  ThemeExtension<AppStyle> lerp(
    covariant ThemeExtension<AppStyle>? other,
    double t,
  ) => this;
}
