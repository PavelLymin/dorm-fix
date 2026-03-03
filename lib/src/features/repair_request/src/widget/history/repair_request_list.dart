import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../chat/chat.dart';
import '../../../request.dart';
import 'item_list.dart';

class RepairRequestList extends StatefulWidget {
  const RepairRequestList({super.key});

  @override
  State<RepairRequestList> createState() => _RepairRequestListState();
}

class _RepairRequestListState extends State<RepairRequestList> {
  late double _height;
  late final IChatRealTimeRepository _chatRealTimeRepository;

  @override
  void initState() {
    super.initState();
    _chatRealTimeRepository = DependeciesScope.of(
      context,
    ).chatRealTimeRepository;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EstimatedSizes.estimateHeightDescription(context);
    _height = EstimatedSizes.estimateHeight(context);
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: AppPadding.contentPadding,
    sliver: BlocBuilder<RepairRequestBloc, RepairRequestState>(
      builder: (context, state) => state.maybeMap(
        orElse: () => const SliverToBoxAdapter(),
        loading: (_) => const _LoadingList(),
        loaded: (state) => SliverFixedExtentList(
          itemExtent: _height,
          delegate: SliverChildBuilderDelegate(
            childCount: state.requests.length,
            (context, index) => Padding(
              padding: EstimatedSizes.listPadding,
              child: _OpenItem(
                request: state.requests[index],
                chatRealTimeRepository: _chatRealTimeRepository,
              ),
            ),
          ),
        ),
      ),
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
  const _OpenItem({
    required this.request,
    required this.chatRealTimeRepository,
  });

  final FullRepairRequest request;
  final IChatRealTimeRepository chatRealTimeRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return OpenContainer(
      openElevation: .0,
      closedElevation: .0,
      closedShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      closedColor: palette.background,
      openColor: palette.background,
      openBuilder: (_, _) => GestureDetector(
        onTap: () => chatRealTimeRepository.joinToChat(chatId: request.chat.id),
        child: ChatScreen(),
      ),
      closedBuilder: (_, _) => Item(request: request),
      onClosed: (_) =>
          chatRealTimeRepository.leaveFromChat(chatId: request.chat.id),
    );
  }
}
