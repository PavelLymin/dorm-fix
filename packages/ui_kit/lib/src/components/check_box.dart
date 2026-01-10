import 'package:ui_kit/ui.dart';

class UiCheckBox extends StatelessWidget {
  const UiCheckBox({super.key, required this.value, required this.onChanged});

  final bool? value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Checkbox(
      value: value,
      onChanged: onChanged,
      materialTapTargetSize: .shrinkWrap,
      fillColor: WidgetStateMapper<Color>({
        WidgetState.selected: colorPalette.primary,
        WidgetState.disabled: colorPalette.secondaryButton,
        WidgetState.any: Colors.transparent,
      }),
      checkColor: colorPalette.accent,
    );
  }
}
