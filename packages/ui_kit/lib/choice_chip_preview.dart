import 'package:ui_kit/ui.dart';

class ChoiceChipPreview extends StatefulWidget {
  const ChoiceChipPreview({super.key});

  @override
  State<ChoiceChipPreview> createState() => _ChoiceChipPreviewState();
}

class _ChoiceChipPreviewState extends State<ChoiceChipPreview> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiChoiceChip<int>(
        options: const [
          ChipItem<int>(value: 1, title: 'Iрорtem 1', icon: Icon(Icons.home)),
          ChipItem<int>(value: 1, title: 'Iрорtem 2', icon: Icon(Icons.home)),
          ChipItem<int>(value: 1, title: 'Iрорtem 3', icon: Icon(Icons.home)),
          ChipItem<int>(value: 1, title: 'Iрорtem 4', icon: Icon(Icons.home)),
        ],
        initial: selected,
        onChange: (index) => setState(() => selected = index),
      ),
    );
  }
}
