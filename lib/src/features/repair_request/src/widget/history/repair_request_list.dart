import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../chat/chat.dart';
import '../../../request.dart';

class RepairRequestList extends StatefulWidget {
  const RepairRequestList({super.key});

  @override
  State<RepairRequestList> createState() => _RepairRequestListState();
}

class _RepairRequestListState extends State<RepairRequestList> {
  late double _height;
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    dependency.chatRealTimeRepository.joinToChat(chatId: 1);

    _chatBloc = ChatBloc(
      webSocket: dependency.webSocket,
      logger: dependency.logger,
      messageRepository: dependency.messageRepository,
      messageRealTimeRepository: dependency.messageRealTimeRepository,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _EstimatedSizes._estimateHeightDescription(context);
    _height = _EstimatedSizes._estimateHeight(context);
  }

  @override
  void dispose() {
    super.dispose();
    _chatBloc.close();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<ChatBloc>.value(
    value: _chatBloc,
    child: SliverPadding(
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
                padding: _EstimatedSizes.listPadding,
                child: _OpenItem(
                  request: state.requests[index],
                  chatBloc: _chatBloc,
                ),
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
        Shimmer(child: _Item(request: FakeFullRepairRequest())),
    separatorBuilder: (_, _) => Padding(padding: _EstimatedSizes.listPadding),
  );
}

abstract class _EstimatedSizes {
  const _EstimatedSizes();

  static EdgeInsets get listPadding => AppPadding.vertical;
  static EdgeInsets get itemPadding =>
      AppPadding.symmetricIncrement(horizontal: 2, vertical: 3);
  static double get spacing => 4.0;
  static double get thickness => 1.0;
  static double get dividerHeight => 32.0;

  static late double heightDescription;

  static TextStyle titleStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return theme.appTypography.bodyMedium.copyWith(color: palette.foreground);
  }

  static double _estimateHeightDescription(BuildContext context) {
    final style = titleStyle(context);
    final twoLineText =
        TextPainter(
          text: TextSpan(text: 'text\ntext', style: style),
          maxLines: 2,
          textDirection: .ltr,
        )..layout(
          maxWidth:
              MediaQuery.sizeOf(context).width -
              AppPadding.pagePadding.horizontal,
        );

    return heightDescription = twoLineText.height;
  }

  static double _estimateHeight(BuildContext context) {
    final style = titleStyle(context);
    final lineText = TextPainter(
      text: TextSpan(style: style),
      maxLines: 1,
      textDirection: .ltr,
    )..layout();

    return lineText.height * 7 +
        heightDescription +
        spacing * 15 +
        thickness +
        dividerHeight +
        itemPadding.vertical +
        listPadding.vertical;
  }
}

class _OpenItem extends StatelessWidget {
  const _OpenItem({required this.request, required this.chatBloc});

  final FullRepairRequest request;
  final ChatBloc chatBloc;

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
      openBuilder: (_, _) => ChatScreen(
        chat: FullChat(requestId: 1, id: 1, createdAt: .now()),
        chatBloc: chatBloc,
      ),
      closedBuilder: (_, _) => _Item(request: request),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return UiCard.standart(
      borderRadius: style.borderRadius,
      padding: _EstimatedSizes.itemPadding,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: _EstimatedSizes.spacing,
        children: [
          Text(
            'Заявка №${request.id}',
            style: _EstimatedSizes.titleStyle(context),
          ),
          SizedBox(
            height: _EstimatedSizes.heightDescription,
            child: Text(
              request.description,
              style: _EstimatedSizes.titleStyle(
                context,
              ).copyWith(color: palette.mutedForeground),
              softWrap: true,
              maxLines: 2,
              overflow: .ellipsis,
            ),
          ),
          Divider(
            height: _EstimatedSizes.dividerHeight,
            thickness: _EstimatedSizes.thickness,
          ),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              _ItemData(
                title: 'Дата',
                value: request.date.toLocal().toString(),
              ),
              _ItemData(title: 'Мастер', value: request.specialization.title),
              _ItemData(title: 'Приоритет', value: request.priority.value),
              _ItemData(
                title: 'Студент отсутствует',
                value: request.studentAbsent ? 'Да' : 'Нет',
              ),
              _ItemData(
                title: 'Время',
                value: '${request.startTime}:00 - ${request.endTime}:00',
              ),
              _ItemStatus(status: request.status),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemData extends StatelessWidget {
  const _ItemData({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return Padding(
      padding: .symmetric(vertical: _EstimatedSizes.spacing),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        spacing: 64.0,
        children: [
          Text(
            title,
            style: _EstimatedSizes.titleStyle(
              context,
            ).copyWith(color: palette.mutedForeground),
          ),
          Flexible(
            child: Text(
              value,
              style: _EstimatedSizes.titleStyle(context),
              softWrap: false,
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemStatus extends StatelessWidget {
  const _ItemStatus({required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    Color statusColor = switch (status) {
      .completed => palette.completed,
      .inProgress => palette.inProgress,
      .newRequest => palette.newRequest,
    };
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      children: [
        Text(
          'Статус',
          style: _EstimatedSizes.titleStyle(
            context,
          ).copyWith(color: palette.mutedForeground),
        ),
        Container(
          width: 128.0,
          padding: .all(_EstimatedSizes.spacing),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: style.borderRadius,
          ),
          child: Text(
            status.value,
            textAlign: .center,
            style: _EstimatedSizes.titleStyle(context),
            overflow: .ellipsis,
          ),
        ),
      ],
    );
  }
}
