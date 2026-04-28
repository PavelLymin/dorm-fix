import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';
import 'request_filter.dart';

class RepairRequestScreen extends StatefulWidget {
  const RepairRequestScreen({
    super.key,
    required this.specId,
    required this.dormId,
  });

  final int specId;
  final int dormId;

  @override
  State<RepairRequestScreen> createState() => _RepairRequestScreenState();
}

class _RepairRequestScreenState extends State<RepairRequestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RepairWatcherBloc>().add(
      .get(specId: widget.specId, dormId: 7),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            const Text('Заявки'),
            UiButton.icon(onPressed: () {}, icon: const Icon(UiIcons.bell)),
          ],
        ),
      ),
      body: Padding(
        padding: AppInsets.screen,
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            const Padding(
              padding: .only(top: 16.0),
              child: RequestSlectedFilter(),
            ),
            Padding(
              padding: .symmetric(vertical: 16.0),
              child: RequestFilter(specId: widget.specId),
            ),
            Expanded(
              child: BlocBuilder<RepairWatcherBloc, RepairWatcherState>(
                builder: (context, state) {
                  return state.maybeMap(
                    orElse: (s) => const SizedBox.shrink(),
                    loaded: (s) {
                      return ListView.separated(
                        itemCount: s.filteredRequests.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 16.0),
                        itemBuilder: (context, index) {
                          final request = s.filteredRequests[index];
                          return _Item(request: request);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return UiCard.clickable(
      onTap: () => context.router.push(
        NamedRoute('MasterRequestDetails', params: {'request': request}),
      ),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 6.0,
        children: [
          UiText2.lBold(request.description),
          UiText2.m(
            '${request.student.dormitory.name}, ${request.student.room.number}',
            color: palette.foregroundSecondary,
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              UiText2.m(
                request.date.toLocal().toIso8601String(),
                color: palette.foregroundSecondary,
              ),
              Icon(UiIcons.chevronRight, color: palette.foregroundSecondary),
            ],
          ),
        ],
      ),
    );
  }
}

class RequestSlectedFilter extends StatefulWidget {
  const RequestSlectedFilter({super.key});

  @override
  State<RequestSlectedFilter> createState() => _RequestSlectedFilterState();
}

class _RequestSlectedFilterState extends State<RequestSlectedFilter> {
  late final ValueNotifier<RequestFilterType> _filter;

  @override
  void initState() {
    super.initState();
    _filter = ValueNotifier<RequestFilterType>(.all);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final style = theme.appStyle;
    return ValueListenableBuilder(
      valueListenable: _filter,
      builder: (context, value, child) {
        return UiSelectedControl<RequestFilterType>(
          options: RequestFilterType.values
              .map((e) => SlectedItem(value: e, title: e.value))
              .toList(),
          initial: value,
          style: SelectedControlStyle(
            barColor: palette.action,
            indicatorColor: palette.card,
            borderRadius: style.borderRadius,
            padding: AppInsets.card,
            textStyle: TextStyle(color: palette.secondary),
          ),
          onChange: (v) {
            _filter.value = v;
            context.read<RepairWatcherBloc>().add(
              RepairWatcherEvent.filterChanged(filter: v),
            );
          },
        );
      },
    );
  }
}
