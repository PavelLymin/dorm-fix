import 'package:ui_kit/ui.dart';

class UiSwitch extends StatelessWidget {
  const UiSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStateMapper<Color>({
        WidgetState.any: colorPalette.accent,
      }),
      trackOutlineColor: WidgetStateMapper<Color>({
        WidgetState.selected: colorPalette.primary,
        WidgetState.any: colorPalette.secondaryButton,
      }),
      trackColor: WidgetStateMapper<Color>({
        WidgetState.selected: colorPalette.primary,
        WidgetState.any: colorPalette.secondaryButton,
      }),
    );
  }
}
