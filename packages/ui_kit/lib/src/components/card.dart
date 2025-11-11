import 'package:ui_kit/ui.dart';

class UiCard extends StatelessWidget {
  const UiCard({required this.child, super.key, this.color, this.padding});
  final Color? color;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color ?? Theme.of(context).colorPalette.secondary,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Padding(
      padding: padding ?? const EdgeInsets.all(24.0),
      child: child,
    ),
  );
}
