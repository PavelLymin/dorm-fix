import 'package:ui_kit/ui.dart';

class AppStyle {
  const AppStyle({
    this.borderRadius = const .all(.circular(24.0)),
    this.inputBorderRadius = const .all(.circular(16.0)),
    this.borderWidth = 1.0,
    this.pagePadding = AppPadding.pagePadding,
    this.shadow = const [
      BoxShadow(
        color: Color(0x0D000000),
        offset: Offset(1, 1),
        blurRadius: 2.0,
      ),
    ],
  });

  final BorderRadius borderRadius;
  final BorderRadius inputBorderRadius;
  final double borderWidth;
  final EdgeInsets pagePadding;
  final List<BoxShadow> shadow;
}

class StyleData {
  const StyleData({
    required this.appStyle,
    required this.lineCalendarStyle,
    required this.groupedListStyle,
  });

  factory StyleData.defaultStyle(
    ColorPalette colorPalette,
    AppTypography typography,
    AppStyle style,
  ) {
    final appStyle = AppStyle();
    return StyleData(
      appStyle: appStyle,
      lineCalendarStyle: LineCalendarStyle(),
      groupedListStyle: GroupedListStyle(),
    );
  }

  final AppStyle appStyle;
  final LineCalendarStyle lineCalendarStyle;
  final GroupedListStyle groupedListStyle;
}
