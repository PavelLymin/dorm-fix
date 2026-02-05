import 'package:ui_kit/ui.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.background,
    required this.foreground,
    required this.card,
    required this.muted,
    required this.mutedForeground,
    required this.border,
    required this.borderStrong,
    required this.borderMuted,
    required this.borderDestructive,
    required this.inputPlaceholder,
    required this.primary,
    required this.primaryForeground,
    required this.inputBorder,
    required this.primaryBorder,
    required this.primaryMuted,
    required this.primaryDestructive,
    required this.secondary,
    required this.destructiveCard,
    required this.destructiveForeground,
    required this.completed,
    required this.inProgress,
    required this.newRequest,
  });

  final Color background;
  final Color foreground;
  final Color card;
  final Color muted;
  final Color mutedForeground;
  final Color border;
  final Color borderStrong;
  final Color borderMuted;
  final Color borderDestructive;
  final Color inputPlaceholder;
  final Color inputBorder;
  final Color primary;
  final Color primaryForeground;
  final Color primaryBorder;
  final Color primaryMuted;
  final Color primaryDestructive;
  final Color secondary;
  final Color destructiveCard;
  final Color destructiveForeground;
  final Color completed;
  final Color inProgress;
  final Color newRequest;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? background,
    Color? foreground,
    Color? card,
    Color? muted,
    Color? mutedForeground,
    Color? border,
    Color? borderStrong,
    Color? borderMuted,
    Color? borderDestructive,
    Color? inputPlaceholder,
    Color? inputBorder,
    Color? primary,
    Color? primaryForeground,
    Color? primaryBorder,
    Color? primaryMuted,
    Color? primaryDestructive,
    Color? secondary,
    Color? destructiveCard,
    Color? destructiveForeground,
    Color? completed,
    Color? inProgress,
    Color? newRequest,
  }) => ColorPalette(
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    card: card ?? this.card,
    muted: muted ?? this.muted,
    mutedForeground: mutedForeground ?? this.mutedForeground,
    border: border ?? this.border,
    borderStrong: borderStrong ?? this.borderStrong,
    borderMuted: borderMuted ?? this.borderMuted,
    borderDestructive: borderDestructive ?? this.borderDestructive,
    inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
    inputBorder: inputBorder ?? this.inputBorder,
    primary: primary ?? this.primary,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    primaryBorder: primaryBorder ?? this.primaryBorder,
    primaryMuted: primaryMuted ?? this.primaryMuted,
    primaryDestructive: primaryDestructive ?? this.primaryDestructive,
    secondary: secondary ?? this.secondary,
    destructiveCard: destructiveCard ?? this.destructiveCard,
    destructiveForeground: destructiveForeground ?? this.destructiveForeground,
    completed: completed ?? this.completed,
    inProgress: inProgress ?? this.inProgress,
    newRequest: newRequest ?? this.newRequest,
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
      background: .lerp(background, other.background, t)!,
      foreground: .lerp(foreground, other.foreground, t)!,
      card: .lerp(card, other.card, t)!,
      muted: .lerp(muted, other.muted, t)!,
      mutedForeground: .lerp(mutedForeground, other.mutedForeground, t)!,
      border: .lerp(border, other.border, t)!,
      borderStrong: .lerp(borderStrong, other.borderStrong, t)!,
      borderMuted: .lerp(borderMuted, other.borderMuted, t)!,
      borderDestructive: .lerp(borderDestructive, other.borderDestructive, t)!,
      inputPlaceholder: .lerp(inputPlaceholder, other.inputPlaceholder, t)!,
      inputBorder: .lerp(inputBorder, other.inputBorder, t)!,
      primary: .lerp(primary, other.primary, t)!,
      primaryForeground: .lerp(primaryForeground, other.primaryForeground, t)!,
      primaryBorder: .lerp(primaryBorder, other.primaryBorder, t)!,
      primaryMuted: .lerp(primaryMuted, other.primaryMuted, t)!,
      primaryDestructive: .lerp(
        primaryDestructive,
        other.primaryDestructive,
        t,
      )!,
      secondary: .lerp(secondary, other.secondary, t)!,
      destructiveCard: .lerp(destructiveCard, other.destructiveCard, t)!,
      destructiveForeground: .lerp(
        destructiveForeground,
        other.destructiveForeground,
        t,
      )!,
      completed: .lerp(completed, other.completed, t)!,
      inProgress: .lerp(inProgress, other.inProgress, t)!,
      newRequest: .lerp(newRequest, other.newRequest, t)!,
    );
  }

  Map<String, Color> toMap() => {
    'Background': background,
    'Foreground': foreground,
    'Card': card,
    'Muted': muted,
    'Muted Foreground': mutedForeground,
    'Border': border,
    'Border Strong': borderStrong,
    'Border Muted': borderMuted,
    'Border Destructive': borderDestructive,
    'Input Placeholder': inputPlaceholder,
    'Input Border': inputBorder,
    'Primary': primary,
    'Primary Foreground': primaryForeground,
    'Primary Border': primaryBorder,
    'Muted Primary': primaryMuted,
    'Primary Destructive': primaryDestructive,
    'Secondary': secondary,
    'Destructive Card': destructiveCard,
    'Destructive Foreground': destructiveForeground,
    'Completed': completed,
    'In Progress': inProgress,
    'New Request': newRequest,
  };
}

class AppGradient extends ThemeExtension<AppGradient> {
  const AppGradient({required this.primary, required this.appBar});

  final Gradient primary;
  final Gradient appBar;

  @override
  ThemeExtension<AppGradient> copyWith({Gradient? primary, Gradient? appBar}) =>
      AppGradient(
        primary: primary ?? this.primary,
        appBar: appBar ?? this.appBar,
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
      primary: .lerp(primary, other.primary, t)!,
      appBar: .lerp(appBar, other.appBar, t)!,
    );
  }

  Map<String, Gradient> toMap() => {'Primary': primary};
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
      displayLarge: .lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: .lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: .lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: .lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: .lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: .lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: .lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: .lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: .lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: .lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: .lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: .lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: .lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: .lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: .lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

class AppStyleData extends ThemeExtension<AppStyleData> {
  const AppStyleData({
    this.style = const AppStyle(),
    this.lineCalendarStyle = const LineCalendarStyle(),
    this.groupedListStyle = const GroupedListStyle(),
  });

  final AppStyle style;
  final LineCalendarStyle lineCalendarStyle;
  final GroupedListStyle groupedListStyle;

  @override
  ThemeExtension<AppStyleData> copyWith({
    AppStyle? style,
    LineCalendarStyle? lineCalendarStyle,
    GroupedListStyle? groupedListStyle,
  }) => AppStyleData(
    style: style ?? this.style,
    lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
    groupedListStyle: groupedListStyle ?? this.groupedListStyle,
  );

  @override
  ThemeExtension<AppStyleData> lerp(
    covariant ThemeExtension<AppStyleData>? other,
    double t,
  ) {
    return this;
  }
}

extension ThemeDataExtensions on ThemeData {
  ColorPalette get colorPalette =>
      extension<ColorPalette>() ?? lightColorPalette;

  AppGradient get appGradient => extension<AppGradient>() ?? lightGradient;

  AppTypography get appTypography =>
      extension<AppTypography>() ?? defaultTypography;

  AppStyleData get appStyleData =>
      extension<AppStyleData>() ?? const AppStyleData();
}
