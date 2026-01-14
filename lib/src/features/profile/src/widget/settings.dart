import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';
import '../../../settings/settings.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPallete = Theme.of(context).colorPalette;
    final textStyle = TextStyle(color: colorPallete.primary);

    return SettingsBuilder(
      builder: (context, settings) {
        final items = _createSettingsList(context, settings, textStyle);
        return GroupedList(items: items);
      },
    );
  }

  List<GroupedListItem> _createSettingsList(
    BuildContext context,
    SettingsEntity settings,
    TextStyle dataStyle,
  ) {
    final icon = const Icon(Icons.chevron_right_rounded);

    return <GroupedListItem>[
      GroupedListItem(
        title: 'Уведомления',
        prefixIcon: Icons.notifications,
        data: 'Выкл.',
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: 'Оформление',
        prefixIcon: Icons.light,
        data: settings.themeMode.value,
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: 'Язык',
        prefixIcon: Icons.language,
        data: 'Русский',
        onTap: () {},
        content: icon,
      ),
      GroupedListItem(
        title: 'Выйти',
        prefixIcon: Icons.logout,
        onTap: () {
          context.read<AuthBloc>().add(.signOut());
          context.router.replace(const NamedRoute('SignIn'));
        },
        content: icon,
      ),
    ];
  }
}
