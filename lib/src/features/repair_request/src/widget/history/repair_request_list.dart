import 'package:animations/animations.dart';
import 'package:ui_kit/ui.dart';
import '../../../../chat/chat.dart';
import '../../../request.dart';
import 'item_list.dart';

class RepairRequestList extends StatefulWidget {
  const RepairRequestList({super.key, required this.requests});

  final Stream<List<FullRepairRequest>> requests;

  @override
  State<RepairRequestList> createState() => _RepairRequestListState();
}

class _RepairRequestListState extends State<RepairRequestList> {
  late double _height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EstimatedSizes.estimateHeightDescription(context);
    _height = EstimatedSizes.estimateHeight(context);
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: context.appStyle.appPadding.contentPadding,
    sliver: StreamBuilder<List<FullRepairRequest>>(
      stream: widget.requests,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Text('Ошибка: ${snapshot.error}'));
        }
        if (!snapshot.hasData) return const _LoadingList();
        final requests = snapshot.data!;
        return SliverFixedExtentList(
          itemExtent: _height,
          delegate: SliverChildBuilderDelegate(
            childCount: requests.length,
            (context, index) => Padding(
              padding: EstimatedSizes.listPadding,
              child: _OpenItem(request: requests[index]),
            ),
          ),
        );
      },
    ),
  );
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemCount: 5,
    itemBuilder: (_, _) =>
        Shimmer(child: Item(request: FakeFullRepairRequest())),
    separatorBuilder: (_, _) => Padding(padding: EstimatedSizes.listPadding),
  );
}

class _OpenItem extends StatelessWidget {
  const _OpenItem({required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final style = context.appStyle.style;
    return OpenContainer(
      openElevation: .0,
      closedElevation: .0,
      closedShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      closedColor: palette.background,
      openColor: palette.background,
      openBuilder: (_, _) => ChatScreen(chatId: request.chat.id),
      closedBuilder: (_, _) => Item(request: request),
    );
  }
}
