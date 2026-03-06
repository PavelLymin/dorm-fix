import 'package:ui_kit/ui.dart';

class CheckBoxPreview extends StatefulWidget {
  const CheckBoxPreview({super.key});

  @override
  State<CheckBoxPreview> createState() => _CheckBoxPreviewState();
}

class _CheckBoxPreviewState extends State<CheckBoxPreview> {
  bool? _value = true;

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: context.appStyle.appPadding.allSmall,
      child: UiCheckBox(
        value: _value,
        onChanged: (value) => setState(() {
          _value = value;
        }),
      ),
    ),
  );
}
