import 'package:ui_kit/ui.dart';

class TextFieldsPreview extends StatefulWidget {
  const TextFieldsPreview({super.key});

  @override
  State<TextFieldsPreview> createState() => _TextFieldsPreviewState();
}

class _TextFieldsPreviewState extends State<TextFieldsPreview> {
  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Column(
      mainAxisSize: .min,
      children: [
        UiTextField.standard(style: UiTextFieldStyle(hintText: 'Text input')),
        SizedBox(height: 16),
        UiTextField.standard(
          style: UiTextFieldStyle(hintText: 'Text input', helperText: 'Helper'),
        ),
        SizedBox(height: 16),
        UiTextField.standard(
          style: UiTextFieldStyle(hintText: 'Text input', errorText: 'Error'),
        ),
        SizedBox(height: 16),
        UiTextField.standard(
          showCounter: true,
          maxLength: 10,
          style: UiTextFieldStyle(hintText: 'Text input'),
        ),
        SizedBox(height: 16),
        UiTextField.standard(
          showCounter: true,
          enabled: false,
          style: UiTextFieldStyle(hintText: 'Disabled'),
        ),
      ],
    ),
  );
}

class SearchFieldsPreview extends StatefulWidget {
  const SearchFieldsPreview({super.key});

  @override
  State<SearchFieldsPreview> createState() => _SearchFieldsPreviewState();
}

class _SearchFieldsPreviewState extends State<SearchFieldsPreview> {
  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Column(
      mainAxisSize: .min,
      children: [
        UiTextField.search(style: UiTextFieldStyle(hintText: 'Search input')),
        SizedBox(height: 16),
        UiTextField.search(
          style: UiTextFieldStyle(
            hintText: 'Search input',
            helperText: 'Helper',
          ),
        ),
        SizedBox(height: 16),
        UiTextField.search(
          style: UiTextFieldStyle(hintText: 'Search input', errorText: 'Error'),
        ),
        SizedBox(height: 16),
        UiTextField.search(
          showCounter: true,
          maxLength: 10,
          style: UiTextFieldStyle(hintText: 'Search input'),
        ),
        SizedBox(height: 16),
        UiTextField.search(
          showCounter: true,
          enabled: false,
          style: UiTextFieldStyle(hintText: 'Disabled search input'),
        ),
      ],
    ),
  );
}
