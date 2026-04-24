import 'package:ui_kit/ui.dart';

class UiSwitch extends StatelessWidget {
  const UiSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette2;
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStateMapper<Color>({WidgetState.any: palette.card}),
      trackOutlineColor: WidgetStateMapper<Color>({
        WidgetState.selected: palette.primary,
        WidgetState.any: palette.secondary,
      }),
      trackColor: WidgetStateMapper<Color>({
        WidgetState.selected: palette.primary,
        WidgetState.any: palette.secondary,
      }),
    );
  }
}
