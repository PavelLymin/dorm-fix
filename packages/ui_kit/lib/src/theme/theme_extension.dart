import 'package:ui_kit/ui.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.background,
    required this.foreground,
    required this.muted,
    required this.mutedForeground,
    required this.border,
    required this.buttonBorder,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryButton,
    required this.secondaryForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.ring,
  });

  final Color background;
  final Color foreground;
  final Color muted;
  final Color mutedForeground;
  final Color border;
  final Color buttonBorder;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryButton;
  final Color secondaryForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;

  final Color ring;
  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? background,
    Color? foreground,
    Color? muted,
    Color? mutedForeground,
    Color? border,
    Color? buttonBorder,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryButton,
    Color? secondaryForeground,
    Color? accent,
    Color? accentForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? ring,
  }) => ColorPalette(
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    muted: muted ?? this.muted,
    mutedForeground: mutedForeground ?? this.mutedForeground,
    border: border ?? this.border,
    buttonBorder: buttonBorder ?? this.buttonBorder,
    primary: primary ?? this.primary,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondary: secondary ?? this.secondary,
    secondaryButton: secondaryButton ?? this.secondaryButton,
    secondaryForeground: secondaryForeground ?? this.secondaryForeground,
    accent: accent ?? this.accent,
    accentForeground: accentForeground ?? this.accentForeground,
    destructive: destructive ?? this.destructive,
    destructiveForeground: destructiveForeground ?? this.destructiveForeground,
    ring: ring ?? this.ring,
  );

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other == null || other is! ColorPalette) {
      return this;
    }

    return ColorPalette(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      buttonBorder: Color.lerp(buttonBorder, other.buttonBorder, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground: Color.lerp(
        primaryForeground,
        other.primaryForeground,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryButton: Color.lerp(secondaryButton, other.secondaryButton, t)!,
      secondaryForeground: Color.lerp(
        secondaryForeground,
        other.secondaryForeground,
        t,
      )!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentForeground: Color.lerp(
        accentForeground,
        other.accentForeground,
        t,
      )!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground: Color.lerp(
        destructiveForeground,
        other.destructiveForeground,
        t,
      )!,
      ring: Color.lerp(ring, other.ring, t)!,
    );
  }

  Map<String, Color> toMap() => {
    'Background': background,
    'Foreground': foreground,
    'Muted': muted,
    'Muted Foreground': mutedForeground,
    'Border': border,
    'ButtonBorder': buttonBorder,
    'Primary': primary,
    'Primary Foreground': primaryForeground,
    'Secondary': secondary,
    'Secondary Button': secondaryButton,
    'Secondary Foreground': secondaryForeground,
    'Accent': accent,
    'Accent Foreground': accentForeground,
    'Destructive': destructive,
    'Destructive Foreground': destructiveForeground,
    'Ring': ring,
  };
}

class AppGradient extends ThemeExtension<AppGradient> {
  const AppGradient({
    required this.background,
    required this.primary,
    required this.muted,
  });

  final Gradient background;
  final Gradient primary;
  final Gradient muted;

  @override
  ThemeExtension<AppGradient> copyWith({
    Gradient? background,
    Gradient? primary,
    Gradient? muted,
  }) => AppGradient(
    background: background ?? this.background,
    primary: primary ?? this.primary,
    muted: muted ?? this.muted,
  );

  @override
  ThemeExtension<AppGradient> lerp(
    covariant ThemeExtension<AppGradient>? other,
    double t,
  ) {
    if (other == null || other is! AppGradient) {
      return this;
    }

    return AppGradient(
      background: Gradient.lerp(background, other.background, t)!,
      primary: Gradient.lerp(primary, other.primary, t)!,
      muted: Gradient.lerp(muted, other.muted, t)!,
    );
  }

  Map<String, Gradient> toMap() => {
    'Background': background,
    'Primary': primary,
    'Muted': muted,
  };
}

class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) => AppTypography(
    displayLarge: displayLarge ?? this.displayLarge,
    displayMedium: displayMedium ?? this.displayMedium,
    displaySmall: displaySmall ?? this.displaySmall,
    headlineLarge: headlineLarge ?? this.headlineLarge,
    headlineMedium: headlineMedium ?? this.headlineMedium,
    headlineSmall: headlineSmall ?? this.headlineSmall,
    titleLarge: titleLarge ?? this.titleLarge,
    titleMedium: titleMedium ?? this.titleMedium,
    titleSmall: titleSmall ?? this.titleSmall,
    bodyLarge: bodyLarge ?? this.bodyLarge,
    bodyMedium: bodyMedium ?? this.bodyMedium,
    bodySmall: bodySmall ?? this.bodySmall,
    labelLarge: labelLarge ?? this.labelLarge,
    labelMedium: labelMedium ?? this.labelMedium,
    labelSmall: labelSmall ?? this.labelSmall,
  );

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other == null || other is! AppTypography) {
      return this;
    }

    return AppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

extension ThemeDataExtensions on ThemeData {
  ColorPalette get colorPalette =>
      extension<ColorPalette>() ?? lightColorPalette;

  AppGradient get appGradient => extension<AppGradient>() ?? lightGradient;

  AppTypography get appTypography =>
      extension<AppTypography>() ?? defaultTypography;
}
