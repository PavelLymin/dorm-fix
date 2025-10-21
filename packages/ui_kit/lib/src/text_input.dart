import '../ui.dart';

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({
    required this.controller,
    required this.autofillHints,
    required this.hintText,
    required this.icon,
    this.width = double.infinity,
    this.height = 64,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
    super.key,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final Function(String text)? onChanged;
  final List<String> autofillHints;
  final String? labelText;
  final String hintText;
  final IconData icon;
  final double width;
  final double height;
  final bool enabled;
  final TextInputType textInputType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child: TextField(
      textAlign: TextAlign.start,
      onChanged: onChanged,
      focusNode: focusNode,
      enabled: enabled,
      maxLines: 1,
      minLines: 1,
      controller: controller,
      autocorrect: false,
      autofillHints: autofillHints,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperMaxLines: 1,
        prefixIcon: Icon(icon),
        errorMaxLines: 1,
        suffixIcon: suffixIcon,
      ),
    ),
  );
}
