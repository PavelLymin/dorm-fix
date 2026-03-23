import 'package:ui_kit/ui.dart';

class MapAppbar extends StatelessWidget {
  const MapAppbar({super.key});

  @override
  Widget build(BuildContext context) => Align(
    alignment: .topStart,
    child: SafeArea(
      child: Padding(
        padding: context.appStyle.appPadding.contentPadding,
        child: UiText.displayLarge(
          'Найдите свое общежитие',
          softWrap: true,
          textAlign: .left,
        ),
      ),
    ),
  );
}
