import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../profile/profile.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) => state.maybeMap(
        orElse: () => const SliverToBoxAdapter(),
        loading: (_) => const _Loading(),
        loadedStudent: (state) => _Loadded(student: state.student),
        error: (state) => SliverPadding(
          padding: AppPadding.appBar(context: context),
          sliver: SliverToBoxAdapter(
            child: UiText.headlineMedium(state.message, overflow: .ellipsis),
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppPadding.appBar(context: context),
      sliver: const SliverToBoxAdapter(
        child: Shimmer(child: _UserDisplay(student: FakeFullStudentEntity())),
      ),
    );
  }
}

class _Loadded extends StatelessWidget {
  const _Loadded({required this.student});

  final FullStudentEntity student;

  @override
  Widget build(BuildContext context) {
    final padding = AppPadding.appBar(context: context);
    return SliverResizingHeader(
      minExtentPrototype: _TitleAppBar(
        title: student.user.displayName ?? 'Name',
        padding: padding,
      ),
      child: BackdropGroup(
        child: ClipRRect(
          child: BackdropFilter.grouped(
            filter: .blur(sigmaX: .9, sigmaY: 4.0),
            child: _UserDisplay(student: student, padding: padding),
          ),
        ),
      ),
    );
  }
}

class _UserDisplay extends StatelessWidget {
  const _UserDisplay({required this.student, this.padding = .zero});

  final FullStudentEntity student;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          _TitleAppBar(
            title: student.user.displayName ?? 'Name',
            colorTitle: palette.primaryForeground,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: '${student.dormitory.name}\n',
                style: typography.headlineLarge.copyWith(
                  fontWeight: .w500,
                  color: palette.foreground,
                ),
                children: [TextSpan(text: student.room.number)],
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
  Widget build(BuildContext context) {
    return Padding(
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
}
