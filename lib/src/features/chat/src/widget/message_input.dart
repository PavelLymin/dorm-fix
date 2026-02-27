import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../core/utils/utils.dart';
import '../../../authentication/authentication.dart';
import '../../chat.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key, required this.chat});

  final FullChat chat;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend() => context.read<AuthBloc>().state.currentUser.map(
    notAuthenticatedUser: (_) =>
        ErrorUtil.showSnackBar(context, 'Вы не авторизованы'),
    authenticatedUser: (user) => context.read<ChatBloc>().add(
      .create(
        message: PartialMessage(
          chatId: widget.chat.id,
          uid: user.uid,
          message: _controller.text,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final padding =
        AppPadding.pagePadding +
        .only(bottom: MediaQuery.paddingOf(context).bottom);
    return Align(
      alignment: .bottomCenter,
      child: BackdropGroup(
        child: ClipRRect(
          child: BackdropFilter.grouped(
            filter: .blur(sigmaX: .9, sigmaY: 4.0),
            child: Padding(
              padding: padding,
              child: UiTextField.standard(
                controller: _controller,
                style: UiTextFieldStyle(
                  suffixIcon: Padding(
                    padding: AppPadding.allIncrement(increment: 0.5),
                    child: UiButton.icon(
                      onPressed: _onSend,
                      icon: const Icon(Icons.arrow_upward_outlined),
                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(CircleBorder()),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
