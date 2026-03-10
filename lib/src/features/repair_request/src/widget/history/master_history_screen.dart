import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../request.dart';
import 'search_appbar.dart';

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
    requests = requestRepository.getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SearchAppBar(),
          RepairRequestList(requests: requests),
        ],
      ),
    );
  }
}
