import 'package:ui_kit/ui.dart';

class UiCard extends StatelessWidget {
  const UiCard({required this.child, super.key, this.color, this.margin});
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) => Surface(
    color: color,
    child: Container(
      padding: margin ?? const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorPalette.primary,
        border: Border.all(
          color: Theme.of(context).colorPalette.border,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(27),
      ),
      child: child,
    ),
  );
}
