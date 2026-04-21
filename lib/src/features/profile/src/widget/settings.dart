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
    final icon = const Icon(UiIcons.sortVertical);

    final l10n = AppLocalizations.of(context);
    return <TileGroupItem>[
      TileGroupItem(
        title: l10n.notifications,
        sufixIcon: icon,
        prefixIcon: Icon(UiIcons.bell),
        subTitle: l10n.notifications_off,
        onTap: () {},
      ),
      TileGroupItem(
        title: l10n.theme,
        sufixIcon: icon,
        prefixIcon: Icon(UiIcons.palette),
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
        prefixIcon: Icon(UiIcons.globe),
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
        context.router.replaceAll([const NamedRoute('SignIn')]);
      },
      icon: Icon(UiIcons.logOut, color: theme.colorPalette2.destructive),
      label: Text(
        'Выйти из профиля',
        style: TextStyle(color: theme.colorPalette2.destructive),
      ),
      style: ButtonStyle(
        backgroundColor: .all(theme.colorPalette2.buttonSecondary),
      ),
    );
  }
}
