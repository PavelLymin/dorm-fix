import 'package:ui_kit/ui.dart';

final lightTheme = createThemeData(
  brightness: .light,
  palette: lightColorPalette,
  typography: defaultTypography,
  style: const AppStyleData(),
);

final darkTheme = createThemeData(
  brightness: .dark,
  palette: darkColorPalette,
  typography: defaultTypography,
  style: const AppStyleData(),
);

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorPalette get colorPalette => theme.colorPalette;
  AppTypography get appTypography => theme.appTypography;
  AppStyleData get appStyle => theme.appStyle;
}
