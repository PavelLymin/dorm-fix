import 'package:ui_kit/ui.dart';

class ScrollableControlPreview extends StatefulWidget {
  const ScrollableControlPreview({super.key});

  @override
  State<ScrollableControlPreview> createState() =>
      _ScrollableControlPreviewState();
}

class _ScrollableControlPreviewState extends State<ScrollableControlPreview> {
  String initial = '0';
  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiScrollableControl<String>(
        initial: initial,
        options: const [
          ScrollableItem(value: '0', title: 'Option 1'),
          ScrollableItem(value: '1', title: 'Option 2'),
          ScrollableItem(value: '2', title: 'Option 3'),
          ScrollableItem(value: '3', title: 'Option 4'),
          ScrollableItem(value: '4', title: 'Option 5'),
          ScrollableItem(value: '5', title: 'Option 6'),
        ],
        onChange: (value) => setState(() {
          initial = value;
        }),
      ),
    );
  }
}
