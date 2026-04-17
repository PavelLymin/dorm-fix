import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';
import 'history_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final RepairRequestBloc _repairRequestBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _repairRequestBloc = RepairRequestBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    )..add(.get(uid: true));
  }

  @override
  void dispose() {
    _repairRequestBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppInsets.screen,
            sliver: SliverSafeArea(
              sliver: SliverMainAxisGroup(
                slivers: [
                  const SliverAppBar(
                    title: Text('История заявок'),
                    toolbarHeight: 42.0,
                  ),
                  const HistorySearch(),
                  HistoryFilter(bloc: _repairRequestBloc),
                  SliverPadding(
                    padding: .only(top: 24.0),
                    sliver: RepairRequest(bloc: _repairRequestBloc),
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
