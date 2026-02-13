import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chat, required this.chatBloc});

  final FullChat chat;
  final ChatBloc chatBloc;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.chatBloc.add(.get(chatId: widget.chat.id));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.chatBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: Column(
          mainAxisSize: .min,
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) => state.maybeMap(
                  orElse: () => const SizedBox.shrink(),
                  loaded: (state) => ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) =>
                        Text(state.messages[index].message),
                  ),
                  error: (state) => Text(state.message.toString()),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(child: UiTextField.standard(controller: _controller)),
                IconButton(
                  onPressed: () => widget.chatBloc.add(
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
          ],
        ),
      ),
    );
  }
}
