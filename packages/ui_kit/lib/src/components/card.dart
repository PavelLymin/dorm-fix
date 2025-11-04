import 'package:ui_kit/ui.dart';

class UiCard extends StatelessWidget {
  const UiCard({required this.child, super.key, this.color, this.margin});
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    margin: margin ?? const EdgeInsets.all(8),
    child: Surface(
      color: color,
      child: DecoratedBox(
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
    ),
  );
}
