import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';
import 'request_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('История заявок')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              const HistorySearch(),
              SliverPadding(
                padding: .only(top: 16.0),
                sliver: SliverToBoxAdapter(child: const RequestFilter()),
              ),
              const SliverPadding(
                padding: .only(top: 24.0),
                sliver: RepairRequest(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
