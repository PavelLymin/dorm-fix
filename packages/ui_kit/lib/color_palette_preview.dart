import 'package:ui_kit/ui.dart';

class ColorPalettePreview extends StatelessWidget {
  const ColorPalettePreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        UiText2.m('Light'),
        const SizedBox(height: 8),
        _PalettePreview(colorPalette: lightColorPalette2),
        const SizedBox(height: 16),
        UiText2.m('Dark'),
        const SizedBox(height: 8),
        _PalettePreview(colorPalette: darkColorPalette2),
      ],
    ),
  );
}

class _PalettePreview extends StatelessWidget {
  const _PalettePreview({required this.colorPalette});

  final ColorPalette2 colorPalette;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 16,
    runSpacing: 16,
    children: colorPalette.toMap().entries.map((entry) {
      final name = entry.key;
      final color = entry.value;

      return SizedBox(
        width: 120,
        height: 100,
        child: Column(
          key: ValueKey(name),
          mainAxisSize: .min,
          children: [
            SizedBox.square(
              dimension: 60,
              child: Material(
                color: color,
                elevation: 2,
                borderRadius: .circular(8),
              ),
            ),
            const SizedBox(height: 8),
            UiText2.xs(name, textAlign: .center),
          ],
        ),
      );
    }).toList(),
  );
}
