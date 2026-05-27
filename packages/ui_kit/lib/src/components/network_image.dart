import '../../ui.dart';

class UiNetworkImage extends StatelessWidget {
  const UiNetworkImage({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return UiCarousel(
      itemCount: images.length,
      itemBuilder: (context, index) {
        final url = images[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: Theme.of(context).appStyle.borderRadius,
            image: DecorationImage(image: NetworkImage(url), fit: .cover),
          ),
        );
      },
      constraints: const BoxConstraints(maxHeight: 220.0),
    );
  }
}
