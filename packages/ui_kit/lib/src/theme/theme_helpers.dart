import 'package:ui_kit/ui.dart';

final lightColorPalette = generatePaletteForBrightness(.light);
final darkColorPalette = generatePaletteForBrightness(.dark);

final AppTypography defaultTypography = AppTypography(
  displayLarge: _material2021.displayLarge!,
  displayMedium: _material2021.displayMedium!,
  displaySmall: _material2021.displaySmall!,
  headlineLarge: _material2021.headlineLarge!,
  headlineMedium: _material2021.headlineMedium!,
  headlineSmall: _material2021.headlineSmall!,
  titleLarge: _material2021.titleLarge!,
  titleMedium: _material2021.titleMedium!,
  titleSmall: _material2021.titleSmall!,
  bodyLarge: _material2021.bodyLarge!,
  bodyMedium: _material2021.bodyMedium!,
  bodySmall: _material2021.bodySmall!,
  labelLarge: _material2021.labelLarge!,
  labelMedium: _material2021.labelMedium!,
  labelSmall: _material2021.labelSmall!,
);

final _material2021 = Typography.material2021().tall.apply(
  fontFamily: 'Inter',
  heightFactor: .72,
);

ThemeData createThemeData({
  required Brightness brightness,
  required ColorPalette palette,
  required ColorPalette2 palette2,
  required AppTypography typography,
  required AppTypography2 typography2,
  required AppStyle style,
}) => ThemeData(
  brightness: brightness,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: palette2.background,
  appBarTheme: appBarTheme(palette2, typography2),
  iconTheme: iconThemeData(palette2),
  extensions: {palette, palette2, typography, style},
);

ColorPalette generatePaletteForBrightness(Brightness brightness) {
  if (brightness == .dark) {
    return ColorPalette(
      background: const Color(0xFF171717),
      foreground: const Color(0xFFFFFFFF),
      card: const Color(0xFF1F1F1F),
      muted: const Color(0xFF212121),
      mutedForeground: const Color(0xFF888888),
      border: const Color(0xFF2E2E2E),
      borderStrong: const Color(0xFF393939),
      borderMuted: const Color(0xFF235139),
      borderDestructive: const Color(0xFF551C15),
      inputPlaceholder: const Color(0xFF252525),
      inputBorder: const Color(0xFF393939),
      primary: const Color(0xFF03623A),
      primaryForeground: const Color(0xFF3FCE8E),
      primaryBorder: const Color(0xFF178252),
      primaryMuted: const Color(0xFF1A412C),
      primaryDestructive: const Color(0xFF551C15),
      secondary: const Color(0xFF2E2E2E),
      destructiveCard: const Color(0xFF1E1412),
      destructiveForeground: const Color(0xFFFFFFFF),
      completed: const Color(0xFFDB6060),
      inProgress: const Color(0xFF045B37),
      newRequest: const Color(0xFFFDFFB9),
    );
  }
  return ColorPalette(
    background: const Color(0xFFFCFCFC),
    foreground: const Color(0xFF000000),
    card: const Color(0xFFFFFFFF),
    muted: const Color(0xFFFDFDFD),
    mutedForeground: const Color(0xFF707070),
    border: const Color(0xFFDFDFDF),
    borderStrong: const Color(0xFFC7C7C7),
    borderMuted: const Color(0xFFA3E0BF),
    borderDestructive: const Color(0xFFFDD9D3),
    inputPlaceholder: const Color(0xFFF6F6F6),
    inputBorder: const Color(0xFFC6C6C6),
    primary: const Color(0xFF71E3AD),
    primaryForeground: const Color(0xFF41CE8E),
    primaryBorder: const Color(0xFF32C282),
    primaryMuted: const Color(0xFFBAF0D5),
    primaryDestructive: const Color(0xFFFFF0ED),
    secondary: const Color(0xFFF3F3F3),
    destructiveCard: const Color(0xFFFFFCFC),
    destructiveForeground: const Color(0xFF000000),
    completed: const Color(0xFFFF8282),
    inProgress: const Color(0xFF74E7B1),
    newRequest: const Color(0xFFEDF275),
  );
}

AppBarTheme appBarTheme(ColorPalette2 palette, AppTypography2 typography) =>
    AppBarTheme(
      centerTitle: false,
      titleSpacing: 20.0,
      toolbarHeight: 32.0,
      backgroundColor: palette.background,
      surfaceTintColor: palette.background,
      foregroundColor: palette.foreground,
      titleTextStyle: typography.h4Bold.copyWith(color: palette.foreground),
    );

IconThemeData iconThemeData(ColorPalette2 palette) =>
    IconThemeData(color: palette.secondary, size: 24.0);
