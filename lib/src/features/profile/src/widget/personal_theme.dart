import 'package:ui_kit/ui.dart';
import '../../../settings/settings.dart';

class PersonalTheme extends StatefulWidget {
  const PersonalTheme({super.key});

  @override
  State<PersonalTheme> createState() => _PersonalThemeState();
}

class _PersonalThemeState extends State<PersonalTheme> {
  late SettingsService _service;

  @override
  void initState() {
    super.initState();
    _service = SettingsScope.of(context).settingsService;
  }

  bool _themeValue(ThemeModeVO mode) {
    final themeValue = switch (mode) {
      ThemeModeVO.light => false,
      ThemeModeVO.dark => true,
      ThemeModeVO.system => true,
    };

    return themeValue;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsBuilder(
      builder: (context, settings) => Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          UiText.titleMedium('Тема приложения'),
          UiSwitch(
            value: _themeValue(settings.themeMode),
            onChanged: (value) async {
              await _service.update(
                (settings) => settings.copyWith(themeMode: ThemeModeVO.dark),
              );
            },
          ),
        ],
      ),
    );
  }
}
