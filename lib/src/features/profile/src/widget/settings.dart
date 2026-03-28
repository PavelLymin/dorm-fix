import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
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

  Future<void> _onChangeTheme(ThemeModeVO themeMode) async =>
      await _settingsService.update((s) => s.copyWith(themeMode: themeMode));

  Future<void> _onChangeLocale(LocaleVO locale) async =>
      await _settingsService.update((s) => s.copyWith(locale: locale));

  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    final textStyle = TextStyle(color: colorPallete.primary);

    return SettingsBuilder(
      builder: (context, settings) {
        final items = _createSettingsList(context, settings, textStyle);
        return GroupedList(divider: .indented(), items: items);
      },
    );
  }

  List<GroupedListItem> _createSettingsList(
    BuildContext context,
    SettingsEntity settings,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.expand_more_outlined);

    final l10n = AppLocalizations.of(context);
    return <GroupedListItem>[
      GroupedListItem(
        title: UiText.bodyMedium(l10n.notifications),
        prefixIcon: Icon(Icons.notifications_none_outlined),
        subTitle: UiText.bodyMedium(l10n.notifications_off),
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: UiText.bodyMedium(l10n.theme),
        prefixIcon: Icon(Icons.light_mode_outlined),
        onTap: () {},
        content: icon,
        selectItems: SelectItem<ThemeModeVO>(
          items: {
            for (final mode in ThemeModeVO.values) mode: mode.label(l10n),
          },
          initial: settings.themeMode,
          onChange: (mode) => _onChangeTheme(mode),
        ),
      ),
      GroupedListItem(
        title: UiText.bodyMedium(l10n.language),
        prefixIcon: Icon(Icons.language_outlined),
        subTitle: UiText.bodyMedium(l10n.russian),
        onTap: () {},
        content: icon,
        selectItems: SelectItem<LocaleVO>(
          items: {for (final l in LocaleVO.values) l: l.label(l10n)},
          initial: settings.locale,
          onChange: (locale) => _onChangeLocale(locale),
        ),
      ),
      GroupedListItem(
        title: UiText.bodyMedium(l10n.logout),
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
