import 'package:ui_kit/ui.dart';

class PinCodePreview extends StatelessWidget {
  const PinCodePreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: context.appStyle.appPadding.allSmall,
      child: PinCode(
        isFocus: true,
        length: 6,
        controller: TextEditingController(),
      ),
    ),
  );
}
