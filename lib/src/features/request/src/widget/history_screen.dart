import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<RepairRequestBloc>().add(.get());
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Scaffold(
      appBar: AppBar(
        title: UiText.headlineLarge('История заявок'),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: Theme.of(context).appTypography.labelLarge,
          unselectedLabelColor: colorPalette.mutedForeground,
          labelColor: colorPalette.primary,
          dividerColor: colorPalette.primary,
          indicatorColor: colorPalette.primary,
          tabs: <Widget>[
            Tab(text: 'Все'),
            Tab(text: 'Принятые'),
            Tab(text: 'Выполненные'),
            Tab(text: 'Отмененные'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: AllRepairRequest()),
          Center(child: Text("It's rainy here")),
          Center(child: Text("It's sunny here")),
          Center(child: Text("It's sunny here")),
        ],
      ),
    );
  }
}

class AllRepairRequest extends StatelessWidget {
  const AllRepairRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairRequestBloc, RepairRequestState>(
      builder: (context, state) => state.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        loaded: (state) => ListView.builder(
          itemCount: state.requests.length,
          itemBuilder: (context, index) =>
              ListTile(title: Text(state.requests[index].description)),
        ),
        error: (state) => UiText.bodyLarge(state.message),
      ),
    );
  }
}
