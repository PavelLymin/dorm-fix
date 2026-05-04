import 'package:ui_kit/ui.dart';

final lightColorPalette2 = generatePaletteByBrightness(.light);
final darkColorPalette2 = generatePaletteByBrightness(.dark);

ColorPalette2 generatePaletteByBrightness(Brightness brightness) {
  if (brightness == .dark) {
    return const ColorPalette2(
      background: Color(0xFF232323),
      primary: Color(0xFF3FCE8E),
      primaryIcon: Color(0xFF3FCE8E),
      secondary: Color(0xFF7B7B7B),
      foreground: Color(0xFFF5F5F5),
      foregroundPrimary: Color(0xFF3FCE8E),
      foregroundSecondary: Color(0xFF7B7B7B),
      foregroundDisabled: Color(0xFF5E5E5E),
      foregroundAccent: Color(0xFF232323),
      disabled: Color(0xFF404040),
      disabledIcon: Color(0xFF999999),
      action: Color(0xFF141414),
      input: Color(0xFF313131),
      inputSearch: Color(0xFF141414),
      card: Color(0xFF313131),
      destructive: Color(0xFFFF4242),
      buttonSecondary: Color(0xFF141414),
      buttonLoading: Color(0xFF0C764C),
      buttonDisabled: Color(0xFF2B5643),
      calendarRange: Color(0xFF11422C),
    );
  }

  return const ColorPalette2(
    background: Color(0xFFF5F5F5),
    primary: Color(0xFF18AC72),
    primaryIcon: Color(0xFF3FCE8E),
    secondary: Color(0xFF7B7B7B),
    foreground: Color(0xFF232323),
    foregroundPrimary: Color(0xFF009530),
    foregroundSecondary: Color(0xFF999999),
    foregroundDisabled: Color(0xFFC2C2C2),
    foregroundAccent: Color(0xFFFFFFFF),
    disabled: Color(0xFFC2C2C2),
    disabledIcon: Color(0xFF7B7B7B),
    action: Color(0xFFEBEBEB),
    input: Color(0xFFFFFFFF),
    inputSearch: Color(0xFFEBEBEB),
    card: Color(0xFFFFFFFF),
    destructive: Color(0xFFDB0505),
    buttonSecondary: Color(0xFFEBEBEB),
    buttonLoading: Color(0xFF0C764C),
    buttonDisabled: Color(0xFF8BD5B8),
    calendarRange: Color(0xFFD1EEE3),
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
    required this.input,
    required this.inputSearch,
    required this.card,
    required this.destructive,
    required this.buttonSecondary,
    required this.buttonLoading,
    required this.buttonDisabled,
    required this.calendarRange,
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
  final Color input;
  final Color inputSearch;
  final Color card;
  final Color destructive;
  final Color buttonSecondary;
  final Color buttonLoading;
  final Color buttonDisabled;
  final Color calendarRange;

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
    Color? input,
    Color? inputSearch,
    Color? card,
    Color? destructive,
    Color? buttonSecondary,
    Color? buttonLoading,
    Color? buttonDisabled,
    Color? calendarRange,
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
    input: input ?? this.input,
    inputSearch: inputSearch ?? this.inputSearch,
    card: card ?? this.card,
    destructive: destructive ?? this.destructive,
    buttonSecondary: buttonSecondary ?? this.buttonSecondary,
    buttonLoading: buttonLoading ?? this.buttonLoading,
    buttonDisabled: buttonDisabled ?? this.buttonDisabled,
    calendarRange: calendarRange ?? this.calendarRange,
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
      input: .lerp(input, other.input, t)!,
      inputSearch: .lerp(inputSearch, other.inputSearch, t)!,
      card: .lerp(card, other.card, t)!,
      destructive: .lerp(destructive, other.destructive, t)!,
      buttonSecondary: .lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonLoading: .lerp(buttonLoading, other.buttonLoading, t)!,
      buttonDisabled: .lerp(buttonDisabled, other.buttonDisabled, t)!,
      calendarRange: .lerp(calendarRange, other.calendarRange, t)!,
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
    'input': input,
    'inputSearch': inputSearch,
    'card': card,
    'destructive': destructive,
    'buttonSecondary': buttonSecondary,
    'buttonLoading': buttonLoading,
    'buttonDisabled': buttonDisabled,
    'calendarRange': calendarRange,
  };
}
