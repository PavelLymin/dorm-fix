import 'package:ui_kit/ui.dart';

class PinCodePreview extends StatelessWidget {
  const PinCodePreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: AppPadding.allSmall,
      child: PinCode(
        isFocus: true,
        length: 6,
        controller: TextEditingController(),
      ),
    ),
  );
}
