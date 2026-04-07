import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../home.dart';
import 'advices.dart';
import 'app_bar.dart';
import 'carousel.dart';
import 'repair_requests.dart';
import 'searcher.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentHomeScreen> {
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _specializationBloc = dependency.specializationBloc
      ..add(.getSpecializations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _specializationBloc,
      child: Scaffold(
        body: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              const HomeAppBar(),
              const SliverToBoxAdapter(child: AppGap.afterAppBar),
              const SliverToBoxAdapter(child: Searcher()),
              const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
              const SliverToBoxAdapter(child: SpecializationsCarousel()),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              // const SliverToBoxAdapter(child: HomeCard.request()),
              // const SliverToBoxAdapter(child: HomeCard.history()),
              SliverToBoxAdapter(child: const RepairRequests()),
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              const SliverToBoxAdapter(child: Advices()),
            ],
          ),
        ),
      ),
    );
  }
}
