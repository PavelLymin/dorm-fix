import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../profile/profile.dart';
import '../../../../repair_request/request.dart';

class MasterHomeScreen extends StatefulWidget {
  const MasterHomeScreen({super.key});

  @override
  State<MasterHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MasterHomeScreen> {
  late final Stream<List<FullRepairRequest>> requests;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    final requestRepository = dependency.requestRepository;
    final master =
        dependency.authenticationBloc.state.currentUser as MasterUser;
    requests = requestRepository.getRequests(
      specId: master.specialization.id,
      dormId: master.dormitory.id,
    );
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
