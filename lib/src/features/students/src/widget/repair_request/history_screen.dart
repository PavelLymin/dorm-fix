import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';
import 'history_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                  const HistoryFilter(),
                  const SliverPadding(
                    padding: .only(top: 24.0),
                    sliver: RepairRequest(),
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
