import 'package:dorm_fix/src/features/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../profile/profile.dart';
import 'carousel.dart';
import 'home_card.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => .fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return AppBar(
      toolbarHeight: 100.0,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        mainAxisSize: .max,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) => state.maybeMap(
              orElse: () => Text('User'),
              loadedStudent: (state) => Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                mainAxisSize: .min,
                children: [
                  Text(
                    state.student.user.displayName!,
                    style: TextStyle(color: palette.primaryForeground),
                  ),
                  UiText.headlineMedium(
                    state.student.dormitory.name,
                    style: TextStyle(fontWeight: .w500),
                  ),
                  UiText.headlineMedium(
                    state.student.room.number,
                    style: TextStyle(fontWeight: .w500),
                  ),
                ],
              ),
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
