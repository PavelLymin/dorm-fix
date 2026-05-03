import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../instructions/instructions.dart';
import '../../../../repair_request/request.dart';
import '../../../../specialization/specialization.dart';
import 'repair_request.dart';
import 'searcher.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<InstructionBloc>().add(.get());
    context.read<SpecializationBloc>().add(.getSpecializations());
    context.read<RepairWatcherBloc>().add(.get(uid: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            const Text('Главная'),
            UiButton.icon(onPressed: () {}, icon: const Icon(UiIcons.bell)),
          ],
        ),
        toolbarHeight: 42.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: AppGap.afterAppBar),
              const SliverToBoxAdapter(child: Searcher()),
              const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
              const SliverToBoxAdapter(child: SpecializationsCarousel()),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              const SliverToBoxAdapter(child: RequestSection()),
              const RepairRequest(itemCount: 2),
              const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
              const SliverToBoxAdapter(child: CreateRequestButton()),
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              const SliverToBoxAdapter(child: InstructionsHorizont()),
            ],
          ),
        ),
      ),
    );
  }
}
