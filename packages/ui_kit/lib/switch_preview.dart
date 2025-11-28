import 'package:ui_kit/ui.dart';

class SwitchPreview extends StatefulWidget {
  const SwitchPreview({super.key});

  @override
  State<SwitchPreview> createState() => _SwitchPreviewState();
}

class _SwitchPreviewState extends State<SwitchPreview> {
  bool _value = true;

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: AppPadding.allSmall,
      child: UiSwitch(
        value: _value,
        onChanged: (value) => setState(() {
          _value = value;
        }),
      ),
    ),
  );
}
