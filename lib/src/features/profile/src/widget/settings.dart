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
        return TileGroup(items: items);
      },
    );
  }

  List<TileGroupItem> _createSettingsList(
    BuildContext context,
    SettingsEntity settings,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.expand_more_outlined);

    final l10n = AppLocalizations.of(context);
    return <TileGroupItem>[
      TileGroupItem(
        title: l10n.notifications,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.notifications_none_outlined),
        subTitle: l10n.notifications_off,
        onTap: () {},
      ),
      TileGroupItem(
        title: l10n.theme,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.light_mode_outlined),
        onTap: () {},
        initial: settings.themeMode.index,
        selectItem: TileSelectItem(
          items: {
            for (int i = 0; i < ThemeModeVO.values.length; i++)
              i: ThemeModeVO.values[i].label(l10n),
          },
          onSelect: (index) => _onChangeTheme(ThemeModeVO.values[index]),
        ),
      ),
      TileGroupItem(
        title: l10n.language,
        sufixIcon: icon,
        prefixIcon: Icon(Icons.language_outlined),
        subTitle: l10n.russian,
        onTap: () {},
        initial: settings.locale.index,
        selectItem: TileSelectItem(
          items: {
            for (int i = 0; i < LocaleVO.values.length; i++)
              i: LocaleVO.values[i].label(l10n),
          },
          onSelect: (index) => _onChangeLocale(LocaleVO.values[index]),
        ),
      ),
    ];
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return UiButton.filledPrimary(
      onPressed: () {
        context.read<AuthBloc>().add(.signOut());
        context.router.replace(const NamedRoute('SignIn'));
      },
      icon: Icon(Icons.logout_outlined, color: theme.colorPalette2.destructive),
      label: UiText2.m(
        'Выйти из профиля',
        color: theme.colorPalette2.destructive,
      ),
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: .all(.circular(24.0))),
        ),
        alignment: .centerStart,
        backgroundColor: .all(theme.colorPalette2.card),
      ),
    );
  }
}
