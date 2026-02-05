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
  required Brightness brightness,
  required ColorPalette palette,
  required AppGradient gradient,
  required AppTypography typography,
  required AppStyleData style,
}) => ThemeData(
  brightness: brightness,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: palette.background,
  appBarTheme: appBarTheme(palette, typography),
  inputDecorationTheme: inputDecorationTheme(palette, typography, style),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: inputDecorationTheme(palette, typography, style),
  ),
  iconTheme: iconThemeData(palette),
  extensions: {palette, gradient, typography, style},
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

AppGradient generateGradientForBrightness(Brightness brightness) {
  late final List<Color> primary;
  late final List<Color> appBar;

  if (brightness == .dark) {
    primary = const [Color(0xFF000000), Color(0xFF2E2E2E)];
    appBar = [
      Color(0xFF171717).withValues(alpha: .9),
      Color(0xFF171717).withValues(alpha: .2),
      Color(0xFF171717).withValues(alpha: .06),
    ];
  } else {
    primary = const [Color(0xFFFFFFFF), Color(0xFFDFDFDF)];
    appBar = [
      Color(0xFFFCFCFC).withValues(alpha: .9),
      Color(0xFFFCFCFC).withValues(alpha: .2),
      Color(0xFFFCFCFC).withValues(alpha: .06),
    ];
  }

  return AppGradient(
    primary: LinearGradient(
      begin: .topLeft,
      end: .topEnd,
      stops: [.5, 1.0],
      colors: primary,
    ),
    appBar: LinearGradient(
      begin: .center,
      end: .bottomCenter,
      stops: [.1, .5, 1.0],
      colors: appBar,
    ),
  );
}

final _material2021 = Typography.material2021().tall.apply(
  fontFamily: 'Inter',
  heightFactor: .72,
);

AppBarTheme appBarTheme(ColorPalette palette, AppTypography typography) {
  return AppBarTheme(
    centerTitle: false,
    titleSpacing: .0,
    backgroundColor: Colors.transparent,
    foregroundColor: palette.primaryForeground,
    surfaceTintColor: palette.background,
    titleTextStyle: typography.headlineLarge.copyWith(
      color: palette.primaryForeground,
      fontWeight: .w700,
    ),
  );
}

InputDecorationTheme inputDecorationTheme(
  ColorPalette palette,
  AppTypography typography,
  AppStyleData style,
) {
  return InputDecorationTheme(
    filled: true,
    fillColor: palette.inputPlaceholder,
    labelStyle: typography.bodyMedium,
    contentPadding: .symmetric(horizontal: 12, vertical: 12),
    constraints: const BoxConstraints(minHeight: 48),
    isDense: true,
    counterStyle: typography.labelSmall.copyWith(
      color: palette.foreground.withValues(alpha: .58),
    ),
    errorStyle: typography.bodySmall.copyWith(
      color: palette.destructiveForeground,
    ),
    hintStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return typography.bodyMedium.copyWith(
          color: palette.foreground.withValues(alpha: .3),
        );
      }
      return typography.bodyMedium.copyWith(
        color: palette.foreground.withValues(alpha: .58),
      );
    }),
    helperStyle: typography.bodySmall.copyWith(
      color: palette.foreground.withValues(alpha: .58),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const .all(.circular(16.0)),
      borderSide: BorderSide(color: palette.borderDestructive, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const .all(.circular(16.0)),
      borderSide: BorderSide(
        color: palette.borderDestructive.withValues(alpha: .3),
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const .all(.circular(16.0)),
      borderSide: BorderSide(color: palette.inputBorder),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const .all(.circular(16.0)),
      borderSide: BorderSide(color: palette.borderMuted),
    ),
  );
}

IconThemeData iconThemeData(ColorPalette palette) =>
    IconThemeData(color: palette.mutedForeground, size: 24.0);
