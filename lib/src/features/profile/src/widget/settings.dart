import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';
import '../../../settings/settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final SettingsService _settingsService;

  @override
  void initState() {
    super.initState();
    _settingsService = SettingsScope.of(context).settingsService;
  }

  Future<void> _onChange(ThemeModeVO themeMode) async =>
      await _settingsService.update((s) => s.copyWith(themeMode: themeMode));

  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    final textStyle = TextStyle(color: colorPallete.primary);

    return SettingsBuilder(
      builder: (context, settings) {
        final items = _createSettingsList(context, settings, textStyle);
        return GroupedList<ThemeModeVO>(divider: .indented(), items: items);
      },
    );
  }

  List<GroupedListItem<ThemeModeVO>> _createSettingsList(
    BuildContext context,
    SettingsEntity settings,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.expand_more_outlined);

    return <GroupedListItem<ThemeModeVO>>[
      GroupedListItem(
        title: UiText.bodyMedium('Уведомления'),
        prefixIcon: Icon(Icons.notifications_none_outlined),
        subTitle: UiText.bodyMedium('Выкл.'),
        onTap: () {},
        content: icon,
      ),
      GroupedListItem<ThemeModeVO>(
        title: UiText.bodyMedium('Оформление'),
        prefixIcon: Icon(Icons.light_mode_outlined),
        onTap: () {},
        content: icon,
        selectItems: SelectItem<ThemeModeVO>(
          items: {for (final mode in ThemeModeVO.values) mode.name: mode},
          initial: settings.themeMode,
          onChange: _onChange,
        ),
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Язык'),
        prefixIcon: Icon(Icons.language_outlined),
        subTitle: UiText.bodyMedium('Русский'),
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium('Выйти'),
        prefixIcon: Icon(Icons.logout_outlined),
        onTap: () {
          context.read<AuthBloc>().add(.signOut());
          context.router.replace(const NamedRoute('SignIn'));
        },
        content: icon,
      ),
    ];
  }
}
