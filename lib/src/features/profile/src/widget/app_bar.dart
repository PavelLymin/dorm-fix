import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../../../../l10n/gen/app_localizations.dart';
import '../../../authentication/authentication.dart';
import 'name_photo_edit.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: .end,
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
              icon: const Icon(UiIcons.edit),
            );
          },
        ),
      ],
    );
  }
}
