import 'package:ui_kit/ui.dart';

class ChoiceOptionsPreview extends StatefulWidget {
  const ChoiceOptionsPreview({super.key});

  @override
  State<ChoiceOptionsPreview> createState() => _ChoiceOptionsPreviewState();
}

class _ChoiceOptionsPreviewState extends State<ChoiceOptionsPreview> {
  int _selected1 = 0;
  int _selected2 = 0;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return UiCard.standart(
      child: Padding(
        padding: AppPadding.allSmall,
        child: Column(
          children: [
            ChoiceOptions(
              options: const [
                ChoiceItem(title: 'Option 1'),
                ChoiceItem(title: 'Option 2'),
                ChoiceItem(title: 'Option 3'),
              ],
              barColor: colorPalette.secondaryButton,
              selectedColor: colorPalette.primary,
              selected: _selected1,
              onChange: (index) {
                setState(() {
                  _selected1 = index;
                });
              },
            ),
            const SizedBox(height: 16),
            ChoiceOptions(
              options: const [
                ChoiceItem(title: 'Option 1', icon: Icons.star_rounded),
                ChoiceItem(title: 'Option 2', icon: Icons.star_rounded),
                ChoiceItem(title: 'Option 3', icon: Icons.star_rounded),
              ],
              barColor: colorPalette.secondaryButton,
              selectedColor: colorPalette.primary,
              selected: _selected2,
              onChange: (index) {
                setState(() {
                  _selected2 = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
