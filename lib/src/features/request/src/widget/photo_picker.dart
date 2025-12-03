import 'package:ui_kit/ui.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return SizedBox(
      height: 150,
      width: .infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorPalette.secondary,
          borderRadius: .circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo, size: 32),
              style: ButtonStyle(backgroundColor: .all(colorPalette.secondary)),
            ),
            UiText.labelMedium('Фото'),
          ],
        ),
      ),
    );
  }
}
