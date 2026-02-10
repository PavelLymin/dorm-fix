import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
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
    )..add(.get(chatId: 1));
  }

  @override
  void dispose() {
    _chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Flexible(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) => state.maybeMap(
                  orElse: () => const SizedBox.shrink(),
                  loaded: (state) => ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) =>
                        Text(state.messages[index].message),
                  ),
                  error: (state) =>
                      SliverToBoxAdapter(child: Text(state.message.toString())),
                ),
              ),
            ),
            Align(
              alignment: .bottomCenter,
              child: Row(
                children: [
                  Flexible(
                    child: UiTextField.standard(controller: _controller),
                  ),
                  IconButton(
                    onPressed: () => _chatBloc.add(
                      .create(
                        message: PartialMessage(
                          chatId: 1,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          message: _controller.text,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
