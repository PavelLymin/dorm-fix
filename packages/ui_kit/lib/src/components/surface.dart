import 'package:ui_kit/ui.dart';

class Surface extends StatelessWidget {
  const Surface({required this.child, this.color, super.key});

  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 0),
            color: Theme.of(
              context,
            ).colorPalette.foreground.withValues(alpha: .24),
          ),
        ],
      ),
      child: child,
    );
  }
}
