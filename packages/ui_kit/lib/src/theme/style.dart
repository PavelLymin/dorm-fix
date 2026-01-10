import 'package:ui_kit/ui.dart';

class AppStyle {
  const AppStyle({
    this.borderRadius = const .all(.circular(16)),
    this.borderWidth = 2,
    this.pagePadding = AppPadding.allLarge,
    this.shadow = const [
      BoxShadow(color: Color(0x0D000000), offset: Offset(1, 1), blurRadius: 2),
    ],
  });

  final BorderRadius borderRadius;

  final double borderWidth;

  final EdgeInsets pagePadding;

  final List<BoxShadow> shadow;
}
