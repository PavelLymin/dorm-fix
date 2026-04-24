import 'package:ui_kit/ui.dart';

extension ThemeDataExtensions on ThemeData {
  AppTypography2 get appTypography2 =>
      extension<AppTypography2>() ?? defaultTypography2;

  ColorPalette2 get colorPalette2 =>
      extension<ColorPalette2>() ?? lightColorPalette2;

  AppStyle get appStyle => extension<AppStyle>() ?? defaultAppStyle;
}
