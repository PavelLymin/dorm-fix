import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';

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
    context.read<RepairRequestBloc>().add(
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
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: RequestFilter()),
            BlocBuilder<RepairRequestBloc, RepairRequestState>(
              builder: (context, state) {
                return state.maybeMap(
                  orElse: (s) =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                  loaded: (s) {
                    return SliverList.separated(
                      itemCount: s.filteredRequests.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                      itemBuilder: (context, index) {
                        final request = s.filteredRequests[index];
                        return _Item(request: request);
                      },
                    );
                  },
                );
              },
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
      onTap: () {},
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

class RequestFilter extends StatefulWidget {
  const RequestFilter({super.key});

  @override
  State<RequestFilter> createState() => _RequestFilterState();
}

class _RequestFilterState extends State<RequestFilter> {
  late final ValueNotifier<RequestFilterType> _filter;

  @override
  void initState() {
    super.initState();
    _filter = ValueNotifier<RequestFilterType>(.all);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _filter,
      builder: (context, value, child) {
        return UiChoiceChip<RequestFilterType>(
          options: RequestFilterType.values
              .map((e) => ChipItem(value: e, title: e.value))
              .toList(),
          initial: value,
          onChange: (v) {
            _filter.value = v;
            context.read<RepairRequestBloc>().add(.filterChanged(filter: v));
          },
        );
      },
    );
  }
}
