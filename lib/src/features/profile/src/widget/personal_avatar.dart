import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../authentication/authentication.dart';

class PersonalAvatar extends StatelessWidget {
  const PersonalAvatar({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      return state.maybeMap(
        loading: (_) => const _PersonalAvatarView(user: .fake()),
        authenticated: (state) => state.authUser.mapAuthUser(
          firebase: (_) => const SizedBox.shrink(),
          profile: (user) => _PersonalAvatarView(user: user),
        ),
        orElse: () => const SizedBox.shrink(),
      );
    },
  );
}

class _PersonalAvatarView extends StatelessWidget {
  const _PersonalAvatarView({required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return UiCard.standart(
      padding: .all(20.0),
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        spacing: 24.0,
        children: [
          UserAvatar(user: user),
          user.mapAuthUser(
            firebase: (f) => Shimmer(
              child: _TitlePersonalAvatar(
                displayName: user.displayName!,
                title: user.email!,
                subtitle: user.phoneNumber!,
              ),
            ),
            profile: (p) => p.mapRoleUser(
              student: (s) => _TitlePersonalAvatar(
                displayName: s.user.displayName ?? 'User',
                title: localizations.dormitory_name(s.dormitory.number),
                subtitle: s.room.number,
              ),
              master: (m) => _TitlePersonalAvatar(
                displayName: m.user.displayName ?? 'User',
                title: m.specialization.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return user.mapAuthUser(
      firebase: (_) => const Shimmer(child: CircleAvatar(radius: 37.0)),
      profile: (p) => CircleAvatar(
        radius: 37.0,
        backgroundColor: palette.secondary,
        backgroundImage: p.photoURL != null
            ? NetworkImage(user.photoURL!)
            : null,
      ),
    );
  }
}

class _TitlePersonalAvatar extends StatelessWidget {
  const _TitlePersonalAvatar({
    required this.displayName,
    this.title,
    this.subtitle,
  });

  final String displayName;
  final String? title;
  final String? subtitle;

  String? get _title {
    if (title == null && subtitle == null) return null;
    if (title == null) return subtitle;
    if (subtitle == null) return title;

    return '$title, $subtitle';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        UiText2.lBold(displayName),
        if (_title != null)
          UiText2.m(_title!, color: theme.colorPalette2.foregroundSecondary),
      ],
    );
  }
}
