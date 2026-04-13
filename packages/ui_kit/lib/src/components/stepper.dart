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
  }) : _size = Size.zero;

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
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      ellipsis: '...',
      maxLines: 2,
    );

    final subTitlePainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      ellipsis: '...',
      maxLines: 1,
    );

    const point = 8.0;
    const currentPoint = 16.0;
    const spacing = 20.0;
    const lineSpacing = 8.0;
    const textSpacing = 48.0;
    const cardPadV = 6.0;
    const cardPadH = 16.0;
    const centerX = currentPoint / 2;
    const titleLeft = currentPoint + spacing;
    const lineThickness = 2.0;

    final pointCenters = <Offset>[];
    double currentY = 0.0;

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final isActive = i == currentStep;

      // Рассчитываем доступную ширину для title (с учетом паддингов карточки)
      double availableTitleWidth = maxWidth - titleLeft - textSpacing;
      if (isActive) availableTitleWidth -= (cardPadH * 2);

      // Layout Subtitle
      double subtitleHeight = 0.0;
      double subtitleWidth = 0.0;
      if (step.subtitle != null) {
        subTitlePainter
          ..text = TextSpan(
            text: step.subtitle,
            style: typography.s.copyWith(color: palette.foreground),
          )
          ..layout();
        subtitleHeight = subTitlePainter.height;
        subtitleWidth = subTitlePainter.width;
      }

      // Layout Title
      titlePainter
        ..text = TextSpan(
          text: step.title,
          style: isActive
              ? typography.s.copyWith(color: palette.foreground)
              : typography.m.copyWith(color: palette.foregroundSecondary),
        )
        ..layout(maxWidth: availableTitleWidth);

      double titleHeight = titlePainter.height;

      double titleBoxHeight = titleHeight + (isActive ? cardPadV * 2 : 0);

      // Высота всего шага определяется самым высоким элементом
      double stepHeight = titleBoxHeight > subtitleHeight
          ? titleBoxHeight
          : subtitleHeight;

      // ЕДИНЫЙ ЦЕНТР по вертикали для выравнивания точки, title и subtitle
      double itemCenterY = currentY + stepHeight / 2;

      // Отрисовка фона-карточки для активного шага
      if (isActive) {
        final cardRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            titleLeft,
            itemCenterY - titleBoxHeight / 2,
            titlePainter.width + cardPadH * 2,
            titleBoxHeight,
          ),
          const .circular(12.0),
        );

        canvas.drawRRect(
          cardRect,
          Paint()
            ..color = palette.step
            ..style = .fill,
        );
      }

      // Отрисовка Title (центрируем по вертикали относительно itemCenterY)
      titlePainter.paint(
        canvas,
        Offset(
          titleLeft + (isActive ? cardPadH : 0),
          itemCenterY - titleHeight / 2 - (isActive ? 1.5 : 2.0),
        ),
      );

      // Отрисовка Subtitle
      if (step.subtitle != null) {
        subTitlePainter.paint(
          canvas,
          Offset(
            maxWidth - subtitleWidth,
            itemCenterY - subtitleHeight / 2 - (isActive ? 1.5 : 1.0),
          ),
        );
      }

      // Сохраняем центр точки для последующей отрисовки линий
      pointCenters.add(Offset(centerX, itemCenterY));

      // Увеличиваем currentY для следующего шага
      currentY += stepHeight + (i == steps.length - 1 ? 0 : spacing);
    }

    // 2. Отрисовка линий (с отступами lineSpacing)
    final linePaint = Paint()
      ..color = palette.step
      ..strokeWidth = lineThickness
      ..strokeCap = .round;

    for (int i = 0; i < pointCenters.length - 1; i++) {
      final p1 = pointCenters[i];
      final p2 = pointCenters[i + 1];

      final r1 = (i == currentStep ? currentPoint : point) / 2;
      final r2 = ((i + 1) == currentStep ? currentPoint : point) / 2;

      final startY = p1.dy + r1 + lineSpacing;
      final endY = p2.dy - r2 - lineSpacing;

      if (endY > startY) {
        canvas.drawLine(
          Offset(centerX, startY),
          Offset(centerX, endY),
          linePaint,
        );
      }
    }

    // 3. Отрисовка самих точек
    for (int i = 0; i < pointCenters.length; i++) {
      final isActive = i == currentStep;
      final r = (isActive ? currentPoint : point) / 2;

      // Активная точка - темная (или currentColor), неактивная - серая
      final color = isActive ? (palette.secondary) : palette.step;

      canvas.drawCircle(
        pointCenters[i],
        r,
        Paint()
          ..color = color
          ..style = .fill,
      );
    }

    _picture = recorder.endRecording();
    return _size = Size(maxWidth, currentY);
  }

  void paint(Canvas canvas, Size size) {
    final picture = _picture;
    if (picture == null) return;
    canvas.drawPicture(picture);
  }
}
