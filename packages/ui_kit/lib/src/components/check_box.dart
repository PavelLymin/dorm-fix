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
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: .resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorPalette.primary;
        }
        return Colors.transparent;
      }),
      checkColor: colorPalette.accent,
    );
  }
}
