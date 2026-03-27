import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../authentication/authentication.dart';

class PersonalAvatar extends StatelessWidget {
  const PersonalAvatar({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      return state.maybeMap(
        loading: (_) => const _PersonalAvatarView(user: .studentFake()),
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

  final ProfileUser user;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    final authUser = user.authenticatedOrNull!;
    return UiCard.standart(
      padding: context.appStyle.appPadding.allMedium,
      child: Row(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        spacing: 24.0,
        children: [
          user.isFake
              ? const Shimmer(child: CircleAvatar(radius: 40.0))
              : CircleAvatar(
                  radius: 40.0,
                  backgroundColor: colorPalette.secondary,
                  backgroundImage: authUser.photoURL != null
                      ? NetworkImage(authUser.photoURL!)
                      : null,
                ),
          user.isFake
              ? Shimmer(
                  child: _TitlePersonalAvatar(
                    displayName: user.displayName!,
                    title: user.email!,
                    subtitle: user.phoneNumber!,
                  ),
                )
              : user.mapRoleUser<Widget>(
                  student: (s) => _TitlePersonalAvatar(
                    displayName: s.user.displayName ?? 'User',
                    title: s.dormitory.name,
                    subtitle: s.room.number,
                  ),
                  master: (m) => _TitlePersonalAvatar(
                    displayName: m.user.displayName ?? 'User',
                    title: m.dormitory.name,
                    subtitle: m.dormitory.address,
                  ),
                ),
        ],
      ),
    );
  }
}

class _TitlePersonalAvatar extends StatelessWidget {
  const _TitlePersonalAvatar({
    required this.displayName,
    required this.title,
    required this.subtitle,
  });

  final String displayName;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        UiText.titleLarge(
          displayName,
          style: TextStyle(color: colorPalette.primaryForeground),
        ),
        UiText.titleMedium(title),
        UiText.titleMedium(subtitle),
      ],
    );
  }
}
