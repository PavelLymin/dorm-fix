import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../request.dart';

class RepairRequests extends StatefulWidget {
  const RepairRequests({super.key, this.itemCount});

  final int? itemCount;

  @override
  State<RepairRequests> createState() => _RepairRequestsState();
}

class _RepairRequestsState extends State<RepairRequests> {
  late final Stream<List<FullRepairRequest>> requests;

  @override
  void initState() {
    super.initState();
    final requestRepository = DependeciesScope.of(context).requestRepository;
    requests = requestRepository.getRequests(uid: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: requests,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Text('Ошибка: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final requests = snapshot.data!;
        int length = requests.length;
        int itemCount = widget.itemCount != null
            ? widget.itemCount! <= length
                  ? widget.itemCount!
                  : length
            : length;
        return SliverList.builder(
          itemBuilder: (_, index) {
            final request = requests[length - index - 1];
            return Padding(
              padding: const .symmetric(vertical: 8.0),
              child: UiDetailCard<Status>(
                key: ValueKey(request.id),
                title: request.description,
                subTitle1: request.date.toLocal().toIso8601String(),
                status: request.status,
                statusText: request.status.value,
                colors: const {
                  .completed: Colors.green,
                  .inProgress: Colors.red,
                  .newRequest: Colors.yellow,
                },
                images: request.problems
                    .map(
                      (e) =>
                          'https://oztyuuvqhgnnzjxclcfv.supabase.co/storage/v1/object/problems/problem/${e.photoPath}',
                    )
                    .toList(),
                onTap: () {},
              ),
            );
          },
          itemCount: itemCount,
        );
      },
    );
  }
}
