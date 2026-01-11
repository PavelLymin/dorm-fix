import 'package:ui_kit/ui.dart';

final lightColorPalette = generatePaletteForBrightness(.light);
final darkColorPalette = generatePaletteForBrightness(.dark);
final lightGradient = generateGradientForBrightness(.light);
final darkGradient = generateGradientForBrightness(.dark);

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
}) => ThemeData(
  brightness: brightness,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: palette.background,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: palette.background,
    foregroundColor: palette.foreground,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: typography.headlineLarge.copyWith(
      color: palette.primary,
      fontWeight: .w700,
    ),
  ),
  extensions: {palette, typography},
);

ColorPalette generatePaletteForBrightness(Brightness brightness) {
  if (brightness == .dark) {
    return ColorPalette(
      background: const Color(0xFF000000),
      foreground: const Color(0xFFFFFFFF),
      muted: const Color(0xFF50ACF9).withValues(alpha: 0.5),
      mutedForeground: const Color(0xFF949494),
      border: const Color(0xFF3B3B3B),
      buttonBorder: Color(0xFF7DB3FC),
      primary: const Color(0xFF50ACF9),
      primaryForeground: const Color(0xFFFFFFFF),
      secondary: const Color(0xFF232325),
      secondaryButton: const Color(0xFF38383A),
      secondaryForeground: const Color(0xFF8A8888),
      accent: const Color(0xFFFFFFFF),
      accentForeground: const Color(0xFFFFFFFF),
      destructive: const Color(0xFFFD273E),
      destructiveForeground: const Color(0xFFFD273E),
      ring: const Color(0xFF3C8BFA),
    );
  }
  return ColorPalette(
    background: const Color(0xFFFFFFFF),
    foreground: const Color(0xFF000000),
    muted: const Color(0xFF50ACF9).withValues(alpha: 0.5),
    mutedForeground: const Color(0xFF949494),
    border: const Color(0xFF3B3B3B),
    buttonBorder: Color(0xFF7DB3FC),
    primary: const Color(0xFF50ACF9),
    primaryForeground: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFEDEDED),
    secondaryButton: const Color(0xFFCECECE),
    secondaryForeground: const Color(0xFF8A8888),
    accent: const Color(0xFF000000),
    accentForeground: const Color(0xFFFFFFFF),
    destructive: const Color(0xFFFD273E),
    destructiveForeground: const Color(0xFFFD273E),
    ring: const Color(0xFF3C8BFA),
  );
}

AppGradient generateGradientForBrightness(Brightness brightness) {
  final background = const LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    stops: [0, 0.66],
    colors: [Color(0xFF2E55BB), Color(0xFF0E0E0E)],
  );

  final primary = const LinearGradient(
    stops: [0, 0.5, 1],
    colors: [Color(0xFF1E60F7), Color(0xFF7DB3FC), Color(0xFF1E60F7)],
  );

  return AppGradient(
    background: background,
    primary: primary,
    muted: primary.withOpacity(0.5),
  );
}

final _material2021 = Typography.material2021().tall.apply(
  fontFamily: 'Inter',
  heightFactor: .72,
);
