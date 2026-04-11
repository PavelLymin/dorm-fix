import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../authentication/authentication.dart';
import 'name_photo_edit.dart';
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = state.authenticatedOrNull;
                    return UiButton.icon(
                      onPressed: user == null
                          ? null
                          : () => showUiBottomSheet(
                              context,
                              title: localizations.name_photo,
                              isScrollControlled: true,
                              widget: NamePhotoEdit(
                                user: user.mapAuthUser(
                                  firebase: (f) => f,
                                  profile: (p) => p.user,
                                ),
                              ),
                            ),
                      icon: const Icon(Icons.edit_outlined),
                    );
                  },
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
