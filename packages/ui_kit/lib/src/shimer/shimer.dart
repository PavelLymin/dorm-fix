import 'package:flutter/foundation.dart';
import 'package:ui_kit/ui.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key, this.size, this.child});

  final Size? size;
  final Widget? child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final ColorPalette _palette;
  late final _controller = AnimationController(vsync: this);
  late final _tween = Tween<double>(
    begin: -1,
    end: 1.5,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  @override
  void initState() {
    super.initState();
    _controller
      ..duration = const Duration(seconds: 2)
      ..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    _palette = theme.colorPalette;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size ?? .zero,
      painter: _ShimmerPainter(
        animation: _tween,
        backgroundColor: _palette.foreground.withValues(alpha: .16),
        radius: 32.0,
        colors: [
          _palette.foreground.withValues(alpha: .0),
          _palette.foreground.withValues(alpha: .16),
          _palette.foreground.withValues(alpha: .0),
        ],
        stops: [0, .5, 1],
      ),
      child: Visibility.maintain(
        visible: false,
        child: widget.child ?? const SizedBox.shrink(),
      ),
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  _ShimmerPainter({
    required this.animation,
    required this.colors,
    required this.radius,
    required this.stops,
    this.backgroundColor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color? backgroundColor;
  final double radius;
  final List<Color> colors;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(.0, .0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, .circular(radius));

    if (backgroundColor != null) {
      final backgroundPaint = Paint()..color = backgroundColor!;
      canvas.drawRRect(rrect, backgroundPaint);
    }

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: .centerLeft,
        end: .centerRight,
        colors: colors,
        stops: stops,
        tileMode: .clamp,
        transform: _SlidingGradientTransform(animation.value),
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter oldDelegate) =>
      oldDelegate.animation.value != animation.value ||
      listEquals(oldDelegate.colors, colors) ||
      listEquals(oldDelegate.stops, stops) ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.radius != radius;
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.offset);

  final double offset;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final resolvedOffset = textDirection == .rtl ? -offset : offset;

    return Matrix4.translationValues(bounds.width * resolvedOffset, .0, .0);
  }
}
