import 'package:ui_kit/ui.dart';

final lightTheme = createThemeData(
  brightness: .light,
  palette: lightColorPalette,
  typography: defaultTypography,
  style: AppStyleData(),
);

final darkTheme = createThemeData(
  brightness: .dark,
  palette: darkColorPalette,
  typography: defaultTypography,
  style: AppStyleData(),
);

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorPalette get palette => theme.extension<ColorPalette>()!;
  AppTypography get typography => theme.extension<AppTypography>()!;
  AppGradient get gradient => theme.extension<AppGradient>()!;
  AppStyleData get appStyle => theme.extension<AppStyleData>()!;
}
