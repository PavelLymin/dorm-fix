import 'package:ui_kit/ui.dart';

class SelectedControlPreview extends StatefulWidget {
  const SelectedControlPreview({super.key});

  @override
  State<SelectedControlPreview> createState() => _SelectedControlPreviewState();
}

class _SelectedControlPreviewState extends State<SelectedControlPreview> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiSelectedControl<int>(
        options: const [
          SlectedItem<int>(
            value: 1,
            title: 'Iрорtem 1',
            icon: Icon(Icons.home),
          ),
          SlectedItem<int>(
            value: 2,
            title: 'Iрорtem 2',
            icon: Icon(Icons.home),
          ),
          SlectedItem<int>(
            value: 3,
            title: 'Iрорtem 3',
            icon: Icon(Icons.home),
          ),
          SlectedItem<int>(
            value: 4,
            title: 'Iрорtem 4',
            icon: Icon(Icons.home),
          ),
        ],
        initial: selected,
        onChange: (index) => setState(() => selected = index),
      ),
    );
  }
}
