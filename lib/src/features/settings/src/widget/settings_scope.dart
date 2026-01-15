import 'package:dorm_fix/src/features/settings/settings.dart';
import 'package:ui_kit/ui.dart';

class SettingsScope extends InheritedWidget {
  const SettingsScope({
    required this.settingsContainer,
    required super.child,
    super.key,
  });

  final SettingsContainer settingsContainer;

  static SettingsContainer _getSettings(BuildContext context) {
    final settings = context
        .getInheritedWidgetOfExactType<SettingsScope>()
        ?.settingsContainer;
    if (settings == null) {
      throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $settings of the exact type',
        'out_of_scope',
      );
    }
    return settings;
  }

  static SettingsContainer of(BuildContext context) {
    SettingsContainer settings = _getSettings(context);
    return settings;
  }

  static ThemeData ofThemeData(BuildContext context, SettingsEntity settings) {
    final themeData = settings.themeMode.map(
      light: (_) => lightTheme,
      dark: (_) => darkTheme,
      system: (_) {
        final brightness = MediaQuery.platformBrightnessOf(context);
        return brightness == Brightness.dark ? darkTheme : lightTheme;
      },
    );

    return themeData;
  }

  @override
  bool updateShouldNotify(covariant SettingsScope oldWidget) {
    return !identical(settingsContainer, oldWidget.settingsContainer);
  }
}
