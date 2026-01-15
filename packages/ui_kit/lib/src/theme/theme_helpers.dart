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
  required AppStyleData style,
  required Brightness brightness,
}) => ThemeData(
  brightness: brightness,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: palette.background,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: palette.background,
    foregroundColor: palette.foreground,
    surfaceTintColor: palette.background,
    titleTextStyle: typography.headlineLarge.copyWith(
      color: palette.primary,
      fontWeight: .w700,
    ),
  ),
  extensions: {palette, typography, style},
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
      borderDestructive: const Color(0xFF551C15),
      inputPlaceholder: const Color(0xFF393939),
      primary: const Color(0xFF32C282),
      primaryLight: const Color(0xFF71E3AD),
      primaryMuted: const Color(0xFF1A412C),
      primaryDestructive: const Color(0xFF551C15),
      secondary: const Color(0xFF2E2E2E),
      destructiveCard: const Color(0xFF1E1412),
      destructiveForeground: const Color(0xFFFFFFFF),
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
    borderDestructive: const Color(0xFFFDD9D3),
    inputPlaceholder: const Color(0xFFF6F6F6),
    primary: const Color(0xFF32C282),
    primaryLight: const Color(0xFF71E3AD),
    primaryMuted: const Color(0xFFBAF0D5),
    primaryDestructive: const Color(0xFFFFF0ED),
    secondary: const Color(0xFFF3F3F3),
    destructiveCard: const Color(0xFFFFFCFC),
    destructiveForeground: const Color(0xFF000000),
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
