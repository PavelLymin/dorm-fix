import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../authentication/authentication.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state.maybeMap(
        orElse: () => const SliverToBoxAdapter(),
        loading: (_) => const _Loading(),
        authenticated: (state) => _Loadded(user: state.authUser),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: context.appStyle.appPadding.appBar(context: context),
    sliver: const SliverToBoxAdapter(
      child: Shimmer(child: _UserDisplay(user: .fake())),
    ),
  );
}

class _Loadded extends StatelessWidget {
  const _Loadded({required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    final padding = context.appStyle.appPadding.appBar(context: context);
    return SliverResizingHeader(
      minExtentPrototype: _TitleAppBar(
        title: user.displayName ?? 'Name',
        padding: padding,
      ),
      child: BackdropGroup(
        child: ClipRRect(
          child: BackdropFilter.grouped(
            filter: .blur(sigmaX: .9, sigmaY: 4.0),
            child: _UserDisplay(user: user, padding: padding),
          ),
        ),
      ),
    );
  }
}

class _UserDisplay extends StatelessWidget {
  const _UserDisplay({required this.user, this.padding = .zero});

  final AuthenticatedUser user;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    final title = user.mapAuthUser(
      firebase: (u) => u.email,
      profile: (u) => u.mapRoleUser(
        student: (u) => u.dormitory.name,
        master: (u) => u.dormitory.name,
      ),
    );
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          _TitleAppBar(
            title: user.displayName ?? 'Name',
            colorTitle: palette.primaryForeground,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: '$title\n',
                style: typography.headlineLarge.copyWith(
                  fontWeight: .w500,
                  color: palette.foreground,
                ),
                children: [
                  TextSpan(
                    text: user.mapAuthUser(
                      firebase: (u) => u.phoneNumber,
                      profile: (u) => u.mapRoleUser(
                        student: (u) => u.room.number,
                        master: (u) => u.dormitory.address,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAppBar extends StatelessWidget {
  const _TitleAppBar({
    required this.title,
    this.padding = .zero,
    this.colorTitle,
  });

  final String title;
  final EdgeInsetsGeometry padding;
  final Color? colorTitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      children: [
        Flexible(
          child: UiText.headlineLarge(
            title,
            style: TextStyle(color: colorTitle, fontWeight: .w700),
          ),
        ),
        UiButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.notifications_on_outlined),
        ),
      ],
    ),
  );
}
