import 'package:ui_kit/ui.dart';

class MapTitle extends StatelessWidget {
  const MapTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: AppPadding.horizontalIncrement(increment: 1),
            child: UiText.displayLarge(
              'Найдите свое общежитие',
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
