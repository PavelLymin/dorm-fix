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
      padding: context.appStyle.appPadding.pagePadding,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              crossAxisAlignment: .center,
              mainAxisAlignment: .spaceBetween,
              mainAxisSize: .max,
              children: [
                Text(localizations.profile),
                UiButton.filledPrimary(
                  onPressed: () {},
                  label: UiText.bodyMedium(localizations.profile_update),
                  style: ButtonStyle(minimumSize: .all(.square(40.0))),
                ),
              ],
            ),
            pinned: true,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: .blur(sigmaX: .9, sigmaY: 4.0),
                child: SizedBox.expand(),
              ),
            ),
          ),
          SliverList.list(
            children: [
              const SizedBox(height: 16.0),
              const PersonalAvatar(),
              const SizedBox(height: 16.0),
              UiText.titleMedium(localizations.personal_data),
              const SizedBox(height: 16.0),
              const PersonalData(),
              const SizedBox(height: 16.0),
              UiText.titleMedium(localizations.system_data),
              const SizedBox(height: 16.0),
              const Settings(),
            ],
          ),
        ],
      ),
    );
  }
}
