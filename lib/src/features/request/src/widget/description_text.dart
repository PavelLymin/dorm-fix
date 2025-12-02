import 'package:ui_kit/ui.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return UiTextField.standard(
      controller: controller,
      maxLines: 5,
      maxLength: 200,
      showCounter: true,
      style: UiTextFieldStyle(hintText: 'Введите текст'),
    );
  }
}
