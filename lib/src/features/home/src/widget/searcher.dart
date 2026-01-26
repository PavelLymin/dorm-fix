import 'dart:developer';

import 'package:ui_kit/ui.dart';

class Searcher extends StatefulWidget {
  const Searcher({super.key});

  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return Padding(
      padding: AppPadding.contentPadding,
      child: GestureDetector(
        onTap: () => log('message'),
        child: UiTextField.standard(
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
