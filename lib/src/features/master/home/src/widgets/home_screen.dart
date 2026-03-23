import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';
import '../../../../root/widget/root_screen.dart';

class MasterHomeScreen extends StatefulWidget {
  const MasterHomeScreen({super.key});

  @override
  State<MasterHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MasterHomeScreen> {
  late final Stream<List<FullRepairRequest>> requests;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dependency = DependeciesScope.of(context);
    final requestRepository = dependency.requestRepository;
    final data = MasterDataScope.of(context);
    requests = requestRepository.getRequests(
      specId: data.specializationId,
      dormId: data.dormitoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [RepairRequestList(requests: requests)]),
    );
  }
}
