import 'package:ui_kit/ui.dart';

final lightTheme = createThemeData(
  brightness: .light,
  palette: lightColorPalette,
  palette2: lightColorPalette2,
  typography: defaultTypography,
  typography2: defaultTypography2,
  style: defaultAppStyle,
);

final darkTheme = createThemeData(
  brightness: .dark,
  palette: darkColorPalette,
  palette2: darkColorPalette2,
  typography: defaultTypography,
  typography2: defaultTypography2,
  style: defaultAppStyle,
);
