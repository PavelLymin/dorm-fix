import 'package:ui_kit/ui.dart';

class PinCodePreview extends StatelessWidget {
  const PinCodePreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: PinCode(
        isFocus: true,
        length: 6,
        controller: TextEditingController(),
      ),
    ),
  );
}
