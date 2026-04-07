import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
      padding: AppInsets.screen,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              crossAxisAlignment: .center,
              mainAxisAlignment: .spaceBetween,
              mainAxisSize: .max,
              children: [
                Text(localizations.profile),
                UiButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          SliverList.list(
            children: [
              const SizedBox(height: 32.0),
              const PersonalAvatar(),
              const SizedBox(height: 24.0),
              UiText2.lBold(localizations.personal_data),
              const SizedBox(height: 10.0),
              const PersonalData(),
              const SizedBox(height: 24.0),
              UiText2.lBold(localizations.system_data),
              const SizedBox(height: 10.0),
              const Settings(),
              const SizedBox(height: 32.0),
              const LogOutButton(),
            ],
          ),
        ],
      ),
    );
  }
}
