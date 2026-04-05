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
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return OpenContainer(
      openElevation: 0.0,
      closedElevation: 0.0,
      closedColor: palette.background,
      openColor: palette.background,
      openBuilder: (context, _) => const SearchScreen(),
      closedBuilder: (context, action) => UiTextField.standard(
        enabled: false,
        style: UiTextFieldStyle(
          prefixIcon: Icon(Icons.search_outlined, color: palette.secondary),
          hintText: 'Поиск',
          hintStyle: TextStyle(color: palette.secondary),
        ),
      ),
    );
  }
}
