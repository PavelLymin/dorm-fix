import 'package:ui_kit/ui.dart';

class DropDownButtonPreview extends StatelessWidget {
  const DropDownButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiDropDownButton<int>(
        selectOnly: true,
        enableFilter: false,
        enableSearch: false,
        showTrailingIcon: false,
        initialSelection: 1,
        onSelected: (value) => debugPrint('Selected: $value'),
        dropdownMenuEntries: [
          DropdownMenuEntry(value: 1, label: 'Option 1'),
          DropdownMenuEntry(value: 2, label: 'Option 2'),
          DropdownMenuEntry(value: 3, label: 'Option 3'),
        ],
      ),
    );
  }
}
