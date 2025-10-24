import 'package:ui_kit/ui.dart';

class Surface extends StatelessWidget {
  const Surface({
    required this.child,
    this.color,
    this.elevation = 0,
    this.shape,
    super.key,
  });

  final double elevation;
  final Color? color;
  final ShapeBorder? shape;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorPalette.background;
    return Material(
      elevation: elevation,
      color: color,
      shape: shape,
      shadowColor: Theme.of(
        context,
      ).colorPalette.foreground.withValues(alpha: .24),
      surfaceTintColor: color,
      child: child,
    );
  }
}
