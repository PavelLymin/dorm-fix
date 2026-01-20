import 'package:ui_kit/ui.dart';

Future<T?> showUiBottomSheet<T>(
  BuildContext context, {
  required Widget widget,
  AnimationStyle anymation = const AnimationStyle(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 150),
    curve: Curves.easeIn,
  ),
  Color? backgroundColor,
  double minWidth = .infinity,
  double maxWidth = .infinity,
  double minHeight = .0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  EdgeInsets? padding,
}) {
  final theme = Theme.of(context);
  final palette = theme.colorPalette;
  final style = theme.appStyleData.style;
  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: anymation,
    backgroundColor: backgroundColor ?? palette.background,
    shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius),
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    useSafeArea: useSafeArea,
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) => Padding(
      padding:
          padding ??
          AppPadding.onlyIncrement(top: 3, left: 3, right: 3, bottom: 8),
      child: widget,
    ),
  );
}
