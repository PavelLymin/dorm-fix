import 'package:ui_kit/src/theme/style_data.dart';
import 'package:ui_kit/ui.dart';

Future<T?> showUiBottomSheet<T>(
  BuildContext context, {
  required Widget widget,
  AnimationStyle style = const AnimationStyle(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 100),
    curve: Curves.easeIn,
  ),
  Color? backgroundColor,
  BorderRadiusGeometry borderRadius = BorderRadius.zero,
  double minWidth = .infinity,
  double maxWidth = .infinity,
  double minHeight = .0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  final colorPalette = Theme.of(context).colorPalette;
  final appStyle = context.styles.appStyle;
  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: style,
    backgroundColor: backgroundColor ?? colorPalette.secondary,
    shape: RoundedSuperellipseBorder(
      side: BorderSide(color: colorPalette.border, width: appStyle.borderWidth),
      borderRadius: borderRadius,
    ),
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    useSafeArea: useSafeArea,
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) =>
        Padding(padding: appStyle.pagePadding, child: widget),
  );
}
