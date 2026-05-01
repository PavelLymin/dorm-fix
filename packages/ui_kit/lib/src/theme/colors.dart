import 'package:ui_kit/ui.dart';

final lightColorPalette2 = generatePaletteByBrightness(.light);
final darkColorPalette2 = generatePaletteByBrightness(.dark);

ColorPalette2 generatePaletteByBrightness(Brightness brightness) {
  if (brightness == .dark) {
    return const ColorPalette2(
      background: Color(0xFFF5F5F5),
      primary: Color(0xFF18AC72),
      primaryIcon: Color(0xFF3FCE8E),
      secondary: Color(0xFF7B7B7B),
      foreground: Color(0xFF232323),
      foregroundPrimary: Color(0xFF009530),
      foregroundSecondary: Color(0xFF7B7B7B),
      foregroundDisabled: Color(0xFFC2C2C2),
      foregroundAccent: Color(0xFF141414),
      disabled: Color(0xFFC2C2C2),
      disabledIcon: Color(0xFFD6D6D6),
      action: Color(0xFFEBEBEB),
      card: Color(0xFFFFFFFF),
      destructive: Color(0xFFDB0505),
      buttonSecondary: Color(0xFFD6D6D6),
      buttonLoading: Color(0xFF0C764C),
      buttonDisabled: Color(0xFF8BD5B8),
    );
  }

  return const ColorPalette2(
    background: Color(0xFFF5F5F5),
    primary: Color(0xFF18AC72),
    primaryIcon: Color(0xFF3FCE8E),
    secondary: Color(0xFF7B7B7B),
    foreground: Color(0xFF232323),
    foregroundPrimary: Color(0xFF009530),
    foregroundSecondary: Color(0xFF7B7B7B),
    foregroundDisabled: Color(0xFFC2C2C2),
    foregroundAccent: Color(0xFFFFFFFF),
    disabled: Color(0xFFC2C2C2),
    disabledIcon: Color(0xFFD6D6D6),
    action: Color(0xFFEBEBEB),
    card: Color(0xFFFFFFFF),
    destructive: Color(0xFFDB0505),
    buttonSecondary: Color(0xFFEBEBEB),
    buttonLoading: Color(0xFF0C764C),
    buttonDisabled: Color(0xFF8BD5B8),
  );
}

class ColorPalette2 extends ThemeExtension<ColorPalette2> {
  const ColorPalette2({
    required this.background,
    required this.primary,
    required this.primaryIcon,
    required this.secondary,
    required this.foreground,
    required this.foregroundPrimary,
    required this.foregroundSecondary,
    required this.foregroundDisabled,
    required this.foregroundAccent,
    required this.disabled,
    required this.disabledIcon,
    required this.action,
    required this.card,
    required this.destructive,
    required this.buttonSecondary,
    required this.buttonLoading,
    required this.buttonDisabled,
  });

  final Color background;
  final Color primary;
  final Color primaryIcon;
  final Color secondary;
  final Color foreground;
  final Color foregroundPrimary;
  final Color foregroundSecondary;
  final Color foregroundDisabled;
  final Color foregroundAccent;
  final Color disabled;
  final Color disabledIcon;
  final Color action;
  final Color card;
  final Color destructive;
  final Color buttonSecondary;
  final Color buttonLoading;
  final Color buttonDisabled;

  @override
  ThemeExtension<ColorPalette2> copyWith({
    Color? background,
    Color? primary,
    Color? primaryIcon,
    Color? secondary,
    Color? foreground,
    Color? foregroundPrimary,
    Color? foregroundSecondary,
    Color? foregroundDisabled,
    Color? foregroundAccent,
    Color? disabled,
    Color? disabledIcon,
    Color? action,
    Color? card,
    Color? destructive,
    Color? buttonSecondary,
    Color? buttonLoading,
    Color? buttonDisabled,
  }) => ColorPalette2(
    background: background ?? this.background,
    primary: primary ?? this.primary,
    primaryIcon: primaryIcon ?? this.primaryIcon,
    secondary: secondary ?? this.secondary,
    foreground: foreground ?? this.foreground,
    foregroundPrimary: foregroundPrimary ?? this.foregroundPrimary,
    foregroundSecondary: foregroundSecondary ?? this.foregroundSecondary,
    foregroundDisabled: foregroundDisabled ?? this.foregroundDisabled,
    foregroundAccent: foregroundAccent ?? this.foregroundAccent,
    disabled: disabled ?? this.disabled,
    disabledIcon: disabledIcon ?? this.disabledIcon,
    action: action ?? this.action,
    card: card ?? this.card,
    destructive: destructive ?? this.destructive,
    buttonSecondary: buttonSecondary ?? this.buttonSecondary,
    buttonLoading: buttonLoading ?? this.buttonLoading,
    buttonDisabled: buttonDisabled ?? this.buttonDisabled,
  );

  @override
  ThemeExtension<ColorPalette2> lerp(
    covariant ThemeExtension<ColorPalette2>? other,
    double t,
  ) {
    if (other == null || other is! ColorPalette2) return this;
    return ColorPalette2(
      background: .lerp(background, other.background, t)!,
      primary: .lerp(primary, other.primary, t)!,
      primaryIcon: .lerp(primaryIcon, other.primaryIcon, t)!,
      secondary: .lerp(secondary, other.secondary, t)!,
      foreground: .lerp(foreground, other.foreground, t)!,
      foregroundPrimary: .lerp(foregroundPrimary, other.foregroundPrimary, t)!,
      foregroundSecondary: .lerp(
        foregroundSecondary,
        other.foregroundSecondary,
        t,
      )!,
      foregroundDisabled: .lerp(
        foregroundDisabled,
        other.foregroundDisabled,
        t,
      )!,
      foregroundAccent: .lerp(foregroundAccent, other.foregroundAccent, t)!,
      disabled: .lerp(disabled, other.disabled, t)!,
      disabledIcon: .lerp(disabledIcon, other.disabledIcon, t)!,
      action: .lerp(action, other.action, t)!,
      card: .lerp(card, other.card, t)!,
      destructive: .lerp(destructive, other.destructive, t)!,
      buttonSecondary: .lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonLoading: .lerp(buttonLoading, other.buttonLoading, t)!,
      buttonDisabled: .lerp(buttonDisabled, other.buttonDisabled, t)!,
    );
  }

  Map<String, Color> toMap() => {
    'background': background,
    'primary': primary,
    'primaryIcon': primaryIcon,
    'secondary': secondary,
    'foreground': foreground,
    'foregroundPrimary': foregroundPrimary,
    'foregroundSecondary': foregroundSecondary,
    'foregroundDisabled': foregroundDisabled,
    'foregroundAccent': foregroundAccent,
    'disabled': disabled,
    'disabledIcon': disabledIcon,
    'action': action,
    'card': card,
    'destructive': destructive,
    'buttonSecondary': buttonSecondary,
    'buttonLoading': buttonLoading,
    'buttonDisabled': buttonDisabled,
  };
}
