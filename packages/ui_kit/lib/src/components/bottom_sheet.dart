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
  double minWidth = .infinity,
  double maxWidth = .infinity,
  double minHeight = .0,
  double maxHeight = .infinity,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  final theme = Theme.of(context);
  final palette = theme.colorPalette;
  final style = theme.appStyleData.style;
  return showModalBottomSheet<T>(
    context: context,
    sheetAnimationStyle: anymation,
    backgroundColor: backgroundColor ?? palette.background,
    shape: RoundedSuperellipseBorder(borderRadius: style.borderRadius),
    useSafeArea: useSafeArea,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    builder: (BuildContext context) => Padding(
      padding: AppPadding.onlyIncrement(top: 2, left: 2, right: 2, bottom: 8),
      child: Column(
        mainAxisSize: .min,
        spacing: 24.0,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              UiText.titleMedium(title),
              UiButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          widget,
        ],
      ),
    ),
  );
}
