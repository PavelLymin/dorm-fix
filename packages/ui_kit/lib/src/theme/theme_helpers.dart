import 'package:ui_kit/ui.dart';

final lightColorPalette = generatePaletteForBrightness(Brightness.light);
final darkColorPalette = generatePaletteForBrightness(Brightness.dark);
final lightGradient = generateGradientForBrightness(Brightness.light);
final darkGradient = generateGradientForBrightness(Brightness.dark);

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

ThemeData createThemeData({
  required ColorPalette palette,
  required AppTypography typography,
  required Brightness brightness,
}) => ThemeData(brightness: brightness, extensions: {palette, typography});

ColorPalette generatePaletteForBrightness(Brightness brightness) {
  final materialPalette = ColorScheme.fromSeed(
    seedColor: Colors.transparent,
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
    brightness: brightness,
  );

  return ColorPalette(
    background: materialPalette.surface,
    foreground: materialPalette.onSurface,
    muted: materialPalette.onSurface.withValues(alpha: .12),
    mutedForeground: materialPalette.onSurface.withValues(alpha: .38),
    border: Color(0xFF3B3B3B),
    buttonBorder: Color(0xFF7DB3FC),
    primary: Color(0xFF212121),
    primaryForeground: Color(0xFFFFFFFF),
    secondary: Color(0xFF292828),
    secondaryForeground: Color(0xFF8A8888),
    accent: materialPalette.tertiary,
    accentForeground: materialPalette.onTertiary,
    destructive: materialPalette.error,
    destructiveForeground: materialPalette.onError,
    ring: const Color.fromARGB(255, 60, 139, 250),
  );
}

AppGradient generateGradientForBrightness(Brightness brightness) {
  final materialPalette = ColorScheme.fromSeed(
    seedColor: Color(0xFF2E55BB),
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
    brightness: brightness,
  );

  final background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 0.66],
    colors: [Color(0xFF2E55BB), Color(0xFF0E0E0E)],
  );

  final primary = LinearGradient(
    stops: [0, 0.5, 1],
    colors: [Color(0xFF1E60F7), Color(0xFF7DB3FC), Color(0xFF1E60F7)],
  );

  return AppGradient(
    background: background,
    primary: primary,
    muted: primary.withOpacity(0.5),
  );
}

final _material2021 = Typography.material2021().tall;
