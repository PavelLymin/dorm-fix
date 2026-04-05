import 'package:ui_kit/ui.dart';

class ChoiceChipPreview extends StatelessWidget {
  const ChoiceChipPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      // child: UiChoiceChip<String>(
      //   initial: '0',
      //   style: UiChoiceChipStyle(
      //     selectedColor: Theme.of(context).colorPalette2.primary,
      //   ),
      //   options: const [
      //     ChipItem(value: '0', title: 'Option 1'),
      //     ChipItem(value: '1', title: 'Option 2'),
      //     ChipItem(value: '2', title: 'Option 3'),
      //     ChipItem(value: '3', title: 'Option 4'),
      //     ChipItem(value: '4', title: 'Option 5'),
      //     ChipItem(value: '5', title: 'Option 6'),
      //   ],
      //   onChange: (value) => log(value),
      // ),
    );
  }
}
