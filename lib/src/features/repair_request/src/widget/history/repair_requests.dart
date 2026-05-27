import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../request.dart';
import '../../model/problem.dart';

class RepairRequest extends StatelessWidget {
  const RepairRequest({super.key, this.itemCount});

  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairWatcherBloc, RepairWatcherState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          ),
          orElse: (state) {
            final List<FullRepairRequest> requests = state.requests;
            return _Loaded(
              itemCount: itemCount ?? requests.length,
              requests: requests,
            );
          },
        );
      },
    );
  }
}

class _Loaded extends StatefulWidget {
  const _Loaded({this.itemCount, required this.requests});

  final int? itemCount;
  final List<FullRepairRequest> requests;

  @override
  State<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<_Loaded> {
  late final IProblemRepository _problemRepository;
  @override
  void initState() {
    super.initState();
    _problemRepository = DependeciesScope.of(context).problemRepository;
  }

  List<String> _getUrl(List<FullProblem> problems) => problems
      .map((e) => _problemRepository.getUrl(photoPath: e.photoPath))
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    int length = widget.requests.length;
    int count = widget.itemCount != null
        ? widget.itemCount! <= length
              ? widget.itemCount!
              : length
        : length;
    return SliverList.builder(
      itemBuilder: (_, index) {
        final request = widget.requests[widget.requests.length - 1 - index];
        final images = _getUrl(request.problems);
        return Padding(
          padding: const .symmetric(vertical: 8.0),
          child: UiDetailCard<StatusEnum>(
            title: request.description,
            subTitle1: request.date.toLocal().toIso8601String(),
            subTitle2: request.specialization.title,
            status: request.currentStatus,
            statusText: request.currentStatus.value,
            colors: {
              .completed: palette.primary,
              .inProgress: palette.background,
              .newRequest: palette.background,
              .canceled: palette.destructive,
              .notDone: palette.foreground,
            },
            textColors: {
              .completed: palette.foregroundAccent,
              .inProgress: palette.foreground,
              .newRequest: palette.foreground,
              .canceled: palette.foregroundAccent,
              .notDone: palette.foreground,
            },
            images: images,
            onTap: () {
              context.router.push(
                NamedRoute(
                  'RepairRequestDetails',
                  params: {'request': request, 'images': images},
                ),
              );
            },
          ),
        );
      },
      itemCount: count,
    );
  }
}
