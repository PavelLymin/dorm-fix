import 'package:animations/animations.dart';
import 'package:ui_kit/ui.dart';

import 'search_screen.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    return Padding(
      padding: context.appStyle.appPadding.contentPadding,
      child: OpenContainer(
        openElevation: 0.0,
        closedElevation: 0.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: context.appStyle.style.inputBorderRadius,
        ),
        closedColor: palette.background,
        openColor: palette.background,
        openBuilder: (context, _) => const SearchScreen(),
        closedBuilder: (context, action) => UiTextField.standard(
          enabled: false,
          style: UiTextFieldStyle(
            prefixIcon: Icon(Icons.search_outlined, color: palette.foreground),
            hintText: 'Что ищете?',
            hintStyle: TextStyle(color: palette.foreground),
          ),
        ),
      ),
    );
  }
}
