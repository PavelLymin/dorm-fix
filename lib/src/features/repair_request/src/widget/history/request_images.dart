import 'package:ui_kit/ui.dart';

class RequestImages extends StatelessWidget {
  const RequestImages({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .only(top: 32.0),
      sliver: SliverToBoxAdapter(child: UiNetworkImage(images: images)),
    );
  }
}
