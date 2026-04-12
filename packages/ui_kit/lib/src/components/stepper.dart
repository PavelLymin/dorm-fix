import 'dart:typed_data';
import 'dart:ui';

import 'package:ui_kit/ui.dart';

class StepItem {
  const StepItem({required this.title, this.subtitle});

  final String title;
  final String? subtitle;
}

class UiStepper extends LeafRenderObjectWidget {
  const UiStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.currentColor,
  });

  final List<StepItem> steps;
  final int currentStep;
  final Color? currentColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final theme = Theme.of(context);

    final painter = StepperPainter(
      steps: steps,
      theme: theme,
      currentStep: currentStep,
      currentColor: currentColor,
    );

    return StepperRenderObject(painter: painter);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant StepperRenderObject renderObject,
  ) {
    if (identical(steps, renderObject.painter.steps)) return;

    final theme = Theme.of(context);
    renderObject.painter.theme = theme;
  }
}

class StepperRenderObject extends RenderBox {
  StepperRenderObject({required this.painter});

  final StepperPainter painter;

  @override
  bool get isRepaintBoundary => false;

  @override
  bool get alwaysNeedsCompositing => false;

  @override
  bool get sizedByParent => false;

  Size _size = Size.zero;

  @override
  Size get size => _size;

  @override
  set size(Size value) {
    final prev = super.hasSize ? super.size : null;
    super.size = value;
    if (prev == value) return;
    _size = value;
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) =>
      constraints.constrain(painter.layout(maxWidth: constraints.maxWidth));

  @override
  void performLayout() {
    size = constraints.constrain(
      painter.layout(maxWidth: constraints.maxWidth),
    );
  }

  @override
  void performResize() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..clipRect(.fromLTWH(0, 0, size.width, size.height).inflate(64.0));

    painter.paint(canvas, size);

    canvas.restore();
  }
}

class StepperPainter {
  StepperPainter({
    required this.theme,
    required this.steps,
    required this.currentStep,
    required this.currentColor,
  }) : _size = .zero;

  ThemeData theme;
  List<StepItem> steps;
  int currentStep;
  Color? currentColor;

  Size _size;
  Size get size => _size;

  Picture? _picture;

  Size layout({required double maxWidth}) {
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    final titlePainter = TextPainter(
      textDirection: .ltr,
      textAlign: .left,
      ellipsis: '...',
      maxLines: 2,
    );

    final subTitlePainter = TextPainter(
      textDirection: .ltr,
      textAlign: .left,
      ellipsis: '...',
      maxLines: 1,
    );

    const pointSize = 8.0;
    const currentPointSize = 16.0;
    const spacing = 12.0;
    const linePadding = 8.0;
    const cardPadV = 6.0;
    const cardPadH = 16.0;

    final pointsList = <double>[];
    final linesList = <double>[];

    double currentY = 0.0;
    double? prevCenterY;
    int? prevStep;

    final centerX = currentPointSize / 2;
    final contentLeft = currentPointSize + spacing;

    for (int i = 0; i < steps.length; i++) {
      if (i != 0) currentY += spacing;
      final isCurrent = i == currentStep;
      double stepHeight;
      double stepWeight;
      double centerY;
      double subtitleWidth = 0.0;
      double titleWidth = maxWidth - contentLeft - subtitleWidth - 48.0;

      if (steps[i].subtitle != null) {
        subTitlePainter
          ..text = TextSpan(
            text: steps[i].subtitle,
            style: typography.s.copyWith(color: palette.foregroundSecondary),
          )
          ..layout();
        subtitleWidth = subTitlePainter.width;
        titleWidth = maxWidth - contentLeft - subtitleWidth - 48.0;
        subTitlePainter.paint(
          canvas,
          Offset(maxWidth - subtitleWidth, currentY + cardPadV),
        );
      }

      if (isCurrent) {
        titlePainter
          ..text = TextSpan(
            text: steps[i].title,
            style: typography.s.copyWith(color: palette.foreground),
          )
          ..layout(maxWidth: titleWidth);

        stepHeight = titlePainter.height + (cardPadV * 2);
        stepWeight = titlePainter.width + (cardPadH * 2);
        centerY = currentY + stepHeight / 2;
        canvas.drawRRect(
          .fromRectAndRadius(
            .fromLTWH(contentLeft, currentY, stepWeight, stepHeight),
            const .circular(12.0),
          ),
          Paint()
            ..color = currentColor ?? palette.foregroundDisabled
            ..style = .fill,
        );

        titlePainter.paint(
          canvas,
          Offset(contentLeft + cardPadH, currentY + cardPadV),
        );
      } else {
        titlePainter
          ..text = TextSpan(
            text: steps[i].title,
            style: typography.m.copyWith(color: palette.foreground),
          )
          ..layout(maxWidth: titleWidth);
        stepHeight = titlePainter.height;
        centerY = currentY + stepHeight / 2;
        titlePainter.paint(canvas, Offset(contentLeft, currentY));
      }

      if (prevCenterY != null) {
        final prevRadius = (prevStep == currentStep)
            ? (currentPointSize / 2)
            : (pointSize / 2);
        final currentRadius = (i == currentStep)
            ? (currentPointSize / 2)
            : (pointSize / 2);
        final startLineY = prevCenterY + prevRadius + linePadding;
        final endLineY = centerY - currentRadius - linePadding;

        if (endLineY > startLineY) {
          linesList.addAll([centerX, startLineY, centerX, endLineY]);
        }
      }

      if (isCurrent) {
        canvas.drawCircle(
          Offset(centerX, centerY),
          currentPointSize / 2,
          Paint()..color = palette.secondary,
        );
      } else {
        pointsList.addAll([centerX, centerY]);
      }

      prevCenterY = centerY;
      prevStep = i;
      currentY += stepHeight;
    }

    _drawLinesAndPoints(canvas, linesList, pointsList, palette, pointSize);

    _picture = recorder.endRecording();
    return _size = Size(maxWidth, currentY);
  }

  void _drawLinesAndPoints(
    Canvas canvas,
    List<double> lines,
    List<double> points,
    ColorPalette2 palette,
    double pointSize,
  ) {
    if (lines.isNotEmpty) {
      canvas.drawRawPoints(
        .lines,
        Float32List.fromList(lines),
        Paint()
          ..color = palette.step
          ..strokeWidth = 2.0
          ..strokeCap = .round,
      );
    }
    if (points.isNotEmpty) {
      canvas.drawRawPoints(
        .points,
        Float32List.fromList(points),
        Paint()
          ..color = palette.step
          ..strokeWidth = pointSize
          ..strokeCap = .round,
      );
    }
  }

  void addPointPos(
    Float32List points,
    int i,
    double pointSize,
    double centerY,
  ) {
    points
      ..[i * 2] = pointSize / 2
      ..[i * 2 + 1] = centerY;
  }

  void paint(Canvas canvas, Size size) {
    final pisture = _picture;
    if (pisture == null) return;
    canvas.drawPicture(pisture);
  }
}
