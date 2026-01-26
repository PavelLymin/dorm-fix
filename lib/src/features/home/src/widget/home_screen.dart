import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../home.dart';
import 'advices.dart';
import 'app_bar.dart';
import 'carousel.dart';
import 'home_card.dart';
import 'searcher.dart';

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
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            const SliverToBoxAdapter(child: SpecializationsCarousel()),
            const SliverToBoxAdapter(child: Searcher()),
            const SliverToBoxAdapter(child: Advices()),
            const SliverToBoxAdapter(child: HomeCard.request()),
            const SliverToBoxAdapter(child: HomeCard.history()),
          ],
        ),
      ),
    );
  }
}
