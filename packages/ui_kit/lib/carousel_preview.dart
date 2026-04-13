import 'package:ui_kit/ui.dart';

class CarouselPreview extends StatelessWidget {
  const CarouselPreview({super.key});

  static const List<String> items = ['Page 1', 'Page 2', 'Page 3'];

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiCarousel(
        constraints: const BoxConstraints(maxHeight: 50.0, minHeight: 50.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorPalette2.primary,
              borderRadius: .all(.circular(24.0)),
            ),
            child: Center(child: UiText2.mBold(items[index])),
          );
        },
      ),
    );
  }
}
