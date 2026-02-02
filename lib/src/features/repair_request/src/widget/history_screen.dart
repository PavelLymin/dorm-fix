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
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    final style = theme.appStyleData.style;
    final itemBorderRadius = style.borderRadius;
    final borderRadius = itemBorderRadius + .circular(8.0);
    return Scaffold(
      appBar: AppBar(
        title: UiText.headlineLarge('История заявок'),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelStyle: typography.labelLarge,
          unselectedLabelColor: palette.mutedForeground,
          labelColor: palette.primary,
          dividerColor: palette.primary,
          indicatorColor: palette.primary,
          tabs: <Widget>[
            Tab(text: 'Все'),
            Tab(text: 'Принятые'),
            Tab(text: 'Выполненные'),
            Tab(text: 'Отмененные'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 2),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              AllRepairRequest(
                borderRadius: borderRadius,
                itemBorderRadius: itemBorderRadius,
              ),
              Center(child: UiText.bodyLarge("Еще ничего нет")),
              Center(child: UiText.bodyLarge("Еще ничего нет")),
              Center(child: UiText.bodyLarge("Еще ничего нет")),
            ],
          ),
        ),
      ),
    );
  }
}

class AllRepairRequest extends StatelessWidget {
  const AllRepairRequest({
    super.key,
    required this.borderRadius,
    required this.itemBorderRadius,
  });

  final BorderRadius borderRadius;
  final BorderRadius itemBorderRadius;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairRequestBloc, RepairRequestState>(
      builder: (context, state) => state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        loaded: (state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.requests.length,
            itemBuilder: (context, index) => _Item(
              request: state.requests[index],
              itemBorderRadius: itemBorderRadius,
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.request, required this.itemBorderRadius});

  final FullRepairRequest request;
  final BorderRadius itemBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.vertical,
      child: UiCard.clickable(
        borderRadius: itemBorderRadius,
        padding: AppPadding.symmetricIncrement(vertical: 3, horizontal: 2),
        onTap: () {},
        child: UiText.bodyLarge(
          request.description,
          overflow: .ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}
