import 'package:ui_kit/ui.dart';

final lightTheme = createThemeData(
  brightness: .light,
  palette: lightColorPalette,
  gradient: lightGradient,
  typography: defaultTypography,
  style: AppStyleData(),
);

final darkTheme = createThemeData(
  brightness: .dark,
  palette: darkColorPalette,
  gradient: darkGradient,
  typography: defaultTypography,
  style: AppStyleData(),
);
