import 'package:ui_kit/ui.dart';

Future<T?> showUiBottomSheet<T>(
  BuildContext context, {
  required Widget widget,
  required String title,
  AnimationStyle anymation = const AnimationStyle(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 150),
    curve: Curves.easeIn,
  ),
  Color? backgroundColor,
  BorderRadius? borderRadius,
  EdgeInsets? padding,
  double spacing = 16.0,
  double minWidth = .infinity,
  double maxWidth = .infinity,
  double minHeight = .0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  final theme = Theme.of(context);
  final palette = theme.colorPalette;
  final style = theme.appStyle;
  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: anymation,
    backgroundColor: backgroundColor ?? palette.background,
    shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
    useSafeArea: useSafeArea,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    builder: (BuildContext context) => Padding(
      padding: padding ?? AppInsets.sheet,
      child: Column(
        mainAxisSize: .min,
        spacing: spacing,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              UiText.titleMedium(title),
              UiButton.icon(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          Flexible(child: widget),
        ],
      ),
    ),
  );
}
