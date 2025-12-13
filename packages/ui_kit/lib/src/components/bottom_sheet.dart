import 'package:ui_kit/ui.dart';

Future<T?> showUiBottomSheet<T>(
  BuildContext context,
  Widget widget, {
  AnimationStyle style = const AnimationStyle(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 100),
  ),
  Color? backgroundColor,
  double minWidth = 0.0,
  double maxWidth = .infinity,
  double minHeight = 0.0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
}) {
  final colorPalette = Theme.of(context).colorPalette;

  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: style,
    backgroundColor: backgroundColor ?? colorPalette.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: .circular(24)),
    ),
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) => MediaQuery.removeViewInsets(
      removeBottom: true,
      context: context,
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          const SizedBox(height: 16),
          const _SheetHandle(),
          Flexible(child: widget),
        ],
      ),
    ),
  );
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette.accent;

    return Container(
      width: 128,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }
}
