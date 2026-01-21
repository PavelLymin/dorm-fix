import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../profile/profile.dart';
import '../../home.dart';
import 'carousel.dart';
import 'home_card.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => .fromHeight(100.0);

  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: 100.0,
    title: Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .start,
      mainAxisSize: .max,
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) => state.maybeMap(
            orElse: () => const SizedBox.shrink(),
            loading: (_) => const Shimmer(child: _UserDisplay()),
            loadedStudent: (state) => _UserDisplay(
              name: state.student.user.displayName,
              dormitory: state.student.dormitory.name,
              room: state.student.room.number,
            ),
            error: (state) =>
                Expanded(child: Text(state.message, overflow: .ellipsis)),
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

class _UserDisplay extends StatelessWidget {
  const _UserDisplay({this.name, this.dormitory, this.room});

  final String? name;
  final String? dormitory;
  final String? room;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      children: [
        Text(
          name ?? 'User',
          style: TextStyle(color: palette.primaryForeground),
        ),
        UiText.headlineMedium(
          dormitory ?? 'Dormitory number',
          style: TextStyle(fontWeight: .w500),
        ),
        UiText.headlineMedium(
          room ?? 'Room number',
          style: TextStyle(fontWeight: .w500),
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    dependency.profileBloc.add(.get());
    _specializationBloc = dependency.specializationBloc
      ..add(.getSpecializations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _specializationBloc,
      child: Padding(
        padding: AppPadding.allMedium,
        child: Scaffold(
          appBar: const _HomeAppBar(),
          body: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 16.0,
            children: [
              const SpecializationsCarousel(),
              HomeCard.request(),
              HomeCard.history(),
            ],
          ),
        ),
      ),
    );
  }
}
