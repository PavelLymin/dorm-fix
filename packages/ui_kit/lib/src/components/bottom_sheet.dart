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
  BorderRadiusGeometry borderRadius = const .only(
    topLeft: .circular(24.0),
    topRight: .circular(24.0),
  ),
  EdgeInsets? padding,
  double spacing = 20.0,
  double minWidth = .infinity,
  double maxWidth = .infinity,
  double minHeight = .0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  final theme = Theme.of(context);
  final palette = theme.colorPalette2;
  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: anymation,
    backgroundColor: backgroundColor ?? palette.background,
    shape: RoundedRectangleBorder(borderRadius: borderRadius),
    useSafeArea: useSafeArea,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    builder: (BuildContext context) => SafeArea(
      child: Padding(
        padding: padding ?? AppInsets.sheet,
        child: Column(
          mainAxisSize: .min,
          spacing: spacing,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                UiText2.lBold(title),
                UiButton.icon(
                  onPressed: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  icon: Icon(UiIcons.close),
                ),
              ],
            ),
            Flexible(child: widget),
          ],
        ),
      ),
    ),
  );
}
