import 'package:ui_kit/ui.dart';

void showUiBottomSheet(
  BuildContext context,
  Widget widget, {
  AnimationStyle style = const AnimationStyle(
    duration: Duration(seconds: 1),
    reverseDuration: Duration(milliseconds: 500),
  ),
  Color? backgroundColor,
  double minWidth = 0.0,
  double maxWidth = double.infinity,
  double minHeight = 0.0,
  double maxHeight = double.infinity,
  bool isScrollControlled = false,
}) {
  final colorPalette = Theme.of(context).colorPalette;
  showModalBottomSheet<void>(
    context: context,
    sheetAnimationStyle: style,
    backgroundColor: backgroundColor ?? colorPalette.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(24),
    ),
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) => Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          width: 128,
          height: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: colorPalette.accent,
            ),
          ),
        ),
        widget,
      ],
    ),
  );
}
