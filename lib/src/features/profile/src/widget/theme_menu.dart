import 'package:ui_kit/ui.dart';
import '../../../settings/settings.dart';

class PersonalTheme extends StatefulWidget {
  const PersonalTheme({super.key});

  @override
  State<PersonalTheme> createState() => _PersonalThemeState();
}

class _PersonalThemeState extends State<PersonalTheme> {
  late final SettingsService _service;

  @override
  void initState() {
    super.initState();
    _service = SettingsScope.of(context).settingsService;
  }

  @override
  Widget build(BuildContext context) {
    return MenuLink(
      actions: {
        'Светлая тема': () =>
            _service.update((settings) => settings.copyWith(themeMode: .light)),
        'Темная тема': () =>
            _service.update((settings) => settings.copyWith(themeMode: .dark)),
        'Системная тема': () => _service.update(
          (settings) => settings.copyWith(themeMode: .system),
        ),
      },
      color: Theme.of(context).colorPalette.secondaryButton,
      child: SettingsBuilder(
        builder: (context, settings) => settings.map(
          light: (_) => const Icon(Icons.mode_night_rounded),
          dark: (_) => const Icon(Icons.light_mode_rounded),
          system: (_) => const Icon(Icons.system_update_rounded),
        ),
      ),
    );
  }
}
