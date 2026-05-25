import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import 'app_bar.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const ProfileAppBar()),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: .only(top: 32.0),
                sliver: SliverToBoxAdapter(child: PersonalAvatar()),
              ),
              SliverPadding(
                padding: .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold(localizations.personal_data),
                ),
              ),
              const SliverToBoxAdapter(child: PersonalData()),
              SliverPadding(
                padding: .only(top: 24.0, bottom: 10.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold(localizations.system_data),
                ),
              ),
              const SliverToBoxAdapter(child: Settings()),
              const SliverPadding(
                padding: .symmetric(vertical: 32.0),
                sliver: SliverToBoxAdapter(child: LogOutButton()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
