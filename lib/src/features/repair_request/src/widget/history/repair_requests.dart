import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/model/application_config.dart';
import '../../../request.dart';

class RepairRequest extends StatelessWidget {
  const RepairRequest({super.key, required this.bloc, this.itemCount});

  final RepairRequestBloc bloc;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<RepairRequestBloc, RepairRequestState>(
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
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({this.itemCount, required this.requests});

  final int? itemCount;
  final List<FullRepairRequest> requests;

  @override
  Widget build(BuildContext context) {
    int length = requests.length;
    int count = itemCount != null
        ? itemCount! <= length
              ? itemCount!
              : length
        : length;
    return SliverList.builder(
      itemBuilder: (_, index) {
        final request = requests[index];
        return Padding(
          padding: const .symmetric(vertical: 8.0),
          child: UiDetailCard<StatusEnum>(
            title: request.description,
            subTitle1: request.date.toLocal().toIso8601String(),
            subTitle2: request.specialization.title,
            status: request.currentStatus,
            statusText: request.currentStatus.value,
            colors: const {
              .completed: Colors.green,
              .inProgress: Colors.red,
              .newRequest: Colors.yellow,
            },
            images: request.problems.map((e) {
              return '${Config.storageBaseUrl}${Config.problemsBucket}${e.photoPath}';
            }).toList(),
            onTap: () {
              context.router.push(
                NamedRoute(
                  'RequestDetailsScreen',
                  params: {'request': request},
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
