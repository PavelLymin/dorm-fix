import 'package:ui_kit/ui.dart';

class ChoiceChipPreview extends StatefulWidget {
  const ChoiceChipPreview({super.key});

  @override
  State<ChoiceChipPreview> createState() => _ChoiceChipPreviewState();
}

class _ChoiceChipPreviewState extends State<ChoiceChipPreview> {
  String initial = '0';
  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiChoiceChip<String>(
        initial: initial,
        options: const [
          ChipItem(value: '0', title: 'Option 1'),
          ChipItem(value: '1', title: 'Option 2'),
          ChipItem(value: '2', title: 'Option 3'),
          // ChipItem(value: '3', title: 'Option 4'),
          // ChipItem(value: '4', title: 'Option 5'),
          // ChipItem(value: '5', title: 'Option 6'),
        ],
        onChange: (value) => setState(() {
          initial = value;
        }),
      ),
    );
  }
}
