import 'package:ui_kit/ui.dart';

class UiCard extends StatelessWidget {
  const UiCard({required this.child, super.key, this.color, this.margin});
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(4),
      child: Surface(
        color: color,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}
