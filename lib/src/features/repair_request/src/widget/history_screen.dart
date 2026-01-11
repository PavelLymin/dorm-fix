import 'package:auto_route/auto_route.dart';
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
      body: Padding(
        padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 2),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            const AllRepairRequest(),
            Center(child: UiText.bodyLarge("Еще ничего нет")),
            Center(child: UiText.bodyLarge("Еще ничего нет")),
            Center(child: UiText.bodyLarge("Еще ничего нет")),
          ],
        ),
      ),
    );
  }
}

class AllRepairRequest extends StatelessWidget {
  const AllRepairRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return BlocBuilder<RepairRequestBloc, RepairRequestState>(
      builder: (context, state) => state.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        loaded: (state) {
          final items = _createGroupedList(
            colorPalette,
            state.requests,
            context,
          );
          return GroupedList(items: items, color: colorPalette.secondary);
        },
        error: (state) => UiText.bodyLarge(state.message),
      ),
    );
  }

  List<GroupedListItem> _createGroupedList(
    ColorPalette colorPalette,
    List<RepairRequestEntity> requests,
    BuildContext context,
  ) {
    final items = requests
        .map(
          (request) => GroupedListItem(
            content: DecoratedBox(
              decoration: BoxDecoration(
                border: .all(color: colorPalette.primary),
                borderRadius: const .all(.circular(16)),
              ),
              child: Padding(
                padding: AppPadding.allSmall,
                child: UiText.labelSmall(
                  request.status.value,
                  color: colorPalette.primary,
                ),
              ),
            ),
            title: request.description,
            data: request.date.toLocal().toString(),
            onTap: () {
              context.router.push(
                NamedRoute(
                  'RepairRequestDetailsScreen',
                  params: {'request': request},
                ),
              );
            },
          ),
        )
        .toList();
    return items;
  }
}
