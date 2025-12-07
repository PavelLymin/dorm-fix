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
      thumbColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        return colorPalette.accent;
      }),
      trackOutlineColor: WidgetStateColor.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return colorPalette.primary;
        }

        return colorPalette.secondaryButton;
      }),
      trackColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorPalette.primary;
        }

        return colorPalette.secondaryButton;
      }),
    );
  }
}
