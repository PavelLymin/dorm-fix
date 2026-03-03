import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../chat.dart';
import 'chat_list.dart';
import 'message_buble.dart';
import 'message_date.dart';
import 'message_input.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  // final FullChat chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _chatBloc = ChatBloc(
      webSocket: dependency.webSocket,
      logger: dependency.logger,
      messageRepository: dependency.messageRepository,
      messageRealTimeRepository: dependency.messageRealTimeRepository,
    )..add(.get(chatId: 1));
  }

  @override
  void dispose() {
    _chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _chatBloc,
    child: Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loaded: (state) => _ChatLoaded(messages: state.messages),
        ),
      ),
    ),
  );
}

class _ChatLoaded extends StatefulWidget {
  const _ChatLoaded({required this.messages});

  // final FullChat chat;
  final List<FullMessage> messages;

  @override
  State<_ChatLoaded> createState() => _ChatLoadedState();
}

class _ChatLoadedState extends State<_ChatLoaded> {
  late final ValueNotifier<Iterable<ItemPosition>> _itemPositionsNotifier;
  late final ValueNotifier<String?> _dateFocusNotifier;
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _itemPositionsNotifier = ValueNotifier({});
    _dateFocusNotifier = ValueNotifier(null);
    _itemPositionsNotifier.addListener(_itemsPositionListeners);
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _itemPositionsNotifier.removeListener(_itemsPositionListeners);
    _itemPositionsNotifier.dispose();
    _dateFocusNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) => '${date.year}-${date.month}-${date.day}';

  void _itemsPositionListeners() {
    final maxIndex = _itemPositionsNotifier.value
        .where((position) => position.leadingEdge < 1)
        .reduce(
          (top, position) =>
              position.leadingEdge > top.leadingEdge ? position : top,
        )
        .index;

    _dateFocusNotifier.value = formatDate(widget.messages[maxIndex].createdAt);
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        RemoteTypingBloc(webSocket: DependeciesScope.of(context).webSocket),
    child: Stack(
      children: [
        Padding(
          padding: AppPadding.pagePadding,
          child: ChatList(
            controller: _controller,
            itemCount: widget.messages.length,
            itemPositionsNotifier: _itemPositionsNotifier,
            itemBuilder: (_, index) => MessageBuble(
              message: widget.messages[index],
              isFirst: index == 0,
            ),
          ),
        ),
        BlocBuilder<RemoteTypingBloc, RemoteTypingState>(
          builder: (context, state) => state.map(
            startTyping: (_) => const Text('Печатает...'),
            stopTyping: (_) => const SizedBox.shrink(),
          ),
        ),
        FloatingDateOverlay(floatingDate: _dateFocusNotifier),
        MessageInput(),
      ],
    ),
  );
}
