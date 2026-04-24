import 'package:ui_kit/ui.dart';

ThemeData createThemeData({
  required Brightness brightness,
  required ColorPalette2 palette2,
  required AppTypography2 typography2,
  required AppStyle style,
}) => ThemeData(
  brightness: brightness,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: palette2.background,
  appBarTheme: appBarTheme(palette2, typography2),
  iconTheme: iconThemeData(palette2),
  extensions: {palette2, style},
);

AppBarTheme appBarTheme(ColorPalette2 palette, AppTypography2 typography) =>
    AppBarTheme(
      centerTitle: false,
      titleSpacing: 20.0,
      toolbarHeight: 42.0,
      backgroundColor: palette.background,
      surfaceTintColor: palette.background,
      foregroundColor: palette.foreground,
      titleTextStyle: typography.h4Bold.copyWith(color: palette.foreground),
    );

IconThemeData iconThemeData(ColorPalette2 palette) =>
    IconThemeData(color: palette.secondary, size: 24.0);
