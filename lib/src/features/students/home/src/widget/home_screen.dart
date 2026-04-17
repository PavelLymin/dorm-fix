import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';
import '../../home.dart';
import 'advices.dart';
import 'app_bar.dart';
import 'carousel.dart';
import 'repair_request.dart';
import 'searcher.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentHomeScreen> {
  late final RepairRequestBloc _repairRequestBloc;
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _specializationBloc = dependency.specializationBloc
      ..add(.getSpecializations());
    _repairRequestBloc = RepairRequestBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    )..add(.get(uid: true));
  }

  @override
  void dispose() {
    _specializationBloc.close();
    _repairRequestBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _repairRequestBloc),
        BlocProvider(create: (context) => _specializationBloc),
      ],
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
              const SliverToBoxAdapter(child: RequestSection()),
              RepairRequest(itemCount: 2, bloc: _repairRequestBloc),
              const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
              const SliverToBoxAdapter(child: CreateRequestButton()),
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              const SliverToBoxAdapter(child: Advices()),
            ],
          ),
        ),
      ),
    );
  }
}
