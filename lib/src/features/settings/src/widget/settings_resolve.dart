import 'package:ui_kit/ui.dart';
import '../../settings.dart';

extension SettingsResolve on ThemeModeVO {
  ThemeData resolve({required Brightness platformBrightness}) {
    return map(
      light: (_) => lightTheme,
      dark: (_) => darkTheme,
      system: (_) => platformBrightness == .dark ? darkTheme : lightTheme,
    );
  }
}
