import 'package:ui_kit/ui.dart';
import '../../chat.dart';

class MessageBuble extends StatelessWidget {
  const MessageBuble({super.key, required this.message, required this.isFirst});

  final FullMessage message;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = 72.0 + MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: .only(top: 8.0, bottom: isFirst ? bottomPadding : 8.0),
      child: UiCard.standart(child: Text(message.message)),
    );
  }
}
