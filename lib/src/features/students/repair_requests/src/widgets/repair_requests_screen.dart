import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final Stream<List<FullRepairRequest>> requests;

  @override
  void initState() {
    super.initState();
    final requestRepository = DependeciesScope.of(context).requestRepository;
    requests = requestRepository.getRequests(uid: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UiButton.filledPrimary(
        onPressed: () => context.router.push(const NamedRoute('RequestScreen')),
        icon: const Icon(Icons.add_outlined),
        label: UiText.titleMedium('Создать заявку'),
      ),
      body: CustomScrollView(
        slivers: [
          const SearchAppBar(),
          RepairRequestList(requests: requests),
        ],
      ),
    );
  }
}
