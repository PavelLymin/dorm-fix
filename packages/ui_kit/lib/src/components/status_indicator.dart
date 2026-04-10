import 'package:ui_kit/ui.dart';

class UiStatusIndicator<T extends Enum> extends StatelessWidget {
  const UiStatusIndicator({
    super.key,
    required this.text,
    required this.value,
    required this.colors,
  });

  final String text;
  final T value;
  final Map<T, Color> colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors[value] ?? palette.card,
        borderRadius: const .all(.circular(12.0)),
      ),
      child: Padding(
        padding: const .symmetric(vertical: 6.0, horizontal: 12.0),
        child: UiText2.s(text),
      ),
    );
  }
}
