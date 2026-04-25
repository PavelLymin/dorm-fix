import 'dart:typed_data';
import 'dart:ui';

import 'package:ui_kit/ui.dart';

class PinIconPainter {
  const PinIconPainter(this.title);

  final String title;

  Canvas _paintCirclePlacemark({
    required double size,
    required ThemeData theme,
    required Canvas canvas,
  }) {
    final radius = size / 2.7;

    final fillPaint = Paint()
      ..color = theme.colorPalette2.primary
      ..style = .fill;

    final circleOffset = Offset(size / 2, size / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);

    final centerX = size / 2;
    final heigth = size / 2;
    final centerY = heigth;
    final leftX = centerX - heigth / 2;
    final rightX = centerX + heigth / 2;

    final path = Path()
      ..moveTo(leftX, centerY)
      ..lineTo(centerX, centerY + heigth)
      ..lineTo(rightX, centerY)
      ..close();

    canvas.drawPath(path, fillPaint);

    return canvas;
  }

  void _paintTextCountPlacemarks({
    required ThemeData theme,
    required String text,
    required double size,
    required Canvas canvas,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: theme.appTypography2.lBold.copyWith(
          color: theme.colorPalette2.foregroundAccent,
          fontSize: 48.0,
        ),
      ),
      textDirection: .ltr,
    )..layout(maxWidth: size);

    final textOffset = Offset(
      (size - textPainter.width) / 2,
      (size - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  Future<Uint8List> getClusterIconBytes({required ThemeData theme}) async {
    final double scaledSize = 150.0;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    _paintCirclePlacemark(theme: theme, size: scaledSize, canvas: canvas);

    _paintTextCountPlacemarks(
      theme: theme,
      text: title,
      size: scaledSize,
      canvas: canvas,
    );

    final image = await recorder.endRecording().toImage(
      scaledSize.toInt(),
      scaledSize.toInt(),
    );
    final pngBytes = await image.toByteData(format: .png);

    return pngBytes!.buffer.asUint8List();
  }
}
