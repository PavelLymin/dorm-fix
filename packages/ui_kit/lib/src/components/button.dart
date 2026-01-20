import 'package:ui_kit/ui.dart';

enum ButtonVariant { filledPrimary, icon }

class UiButton extends ButtonStyleButton {
  UiButton.filledPrimary({
    required VoidCallback? onPressed,
    bool enabled = true,
    IconAlignment iconAlignment = .start,
    Widget? label,
    Widget? icon,
    VoidCallback? onLongPress,
    super.autofocus = false,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.key,
  }) : variant = .filledPrimary,
       super(
         child: _ButtonIconAndLabel(
           icon: icon,
           label: label,
           iconAlignment: iconAlignment,
         ),
         onPressed: enabled ? onPressed : null,
         onLongPress: enabled ? onLongPress : null,
       );

  const UiButton.icon({
    required VoidCallback? onPressed,
    bool enabled = true,
    IconAlignment iconAlignment = .start,
    Widget? icon,
    VoidCallback? onLongPress,
    super.autofocus = false,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.key,
  }) : variant = .icon,
       super(
         child: icon,
         onPressed: enabled ? onPressed : null,
         onLongPress: enabled ? onLongPress : null,
       );

  final ButtonVariant variant;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorPalette;
    final typography = theme.appTypography;

    return switch (variant) {
      ButtonVariant.filledPrimary => _FilledButtonPrimaryStyle(
        colorPalette: colors,
        typography: typography,
      ),

      ButtonVariant.icon => _IconButtonStandardStyle(
        colorPalette: colors,
        typography: typography,
      ),
    };
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => null;
}

class _ButtonIconAndLabel extends StatelessWidget {
  const _ButtonIconAndLabel({
    required this.icon,
    required this.label,
    required this.iconAlignment,
  });

  final Widget? icon;
  final Widget? label;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    children: iconAlignment == .start
        ? [
            if (icon != null) icon!,
            if (icon != null && label != null) const SizedBox(width: 8),
            if (label != null) Flexible(child: label!),
          ]
        : [
            if (label != null) Flexible(child: label!),
            if (icon != null && label != null) const SizedBox(width: 8),
            if (icon != null) icon!,
          ],
  );
}

class _FilledButtonPrimaryStyle extends _UiBaseButtonStyle {
  const _FilledButtonPrimaryStyle({
    required super.colorPalette,
    required super.typography,
  });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.mutedForeground,
        WidgetState.any: colorPalette.foreground,
      });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.primaryMuted,
        WidgetState.any: colorPalette.primary,
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor => AppWidgetStateMap<Color?>({
    WidgetState.pressed: colorPalette.foreground.withValues(alpha: .2),
    WidgetState.hovered: colorPalette.foreground.withValues(alpha: .1),
    WidgetState.focused: colorPalette.foreground.withValues(alpha: .1),
  });

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStatePropertyAll<double>(0.0);

  @override
  WidgetStateProperty<Color>? get shadowColor => WidgetStatePropertyAll<Color>(
    colorPalette.foreground.withValues(alpha: .18),
  );
}

class _UiBaseButtonStyle extends ButtonStyle {
  const _UiBaseButtonStyle({
    required this.colorPalette,
    required this.typography,
  });

  final ColorPalette colorPalette;
  final AppTypography typography;

  @override
  AlignmentGeometry? get alignment => .center;

  @override
  Duration? get animationDuration => const Duration(milliseconds: 200);

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: .all(.circular(16))),
      );

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStateMapper<BorderSide?>({
    WidgetState.disabled: BorderSide(color: colorPalette.borderMuted, width: 1),
    WidgetState.any: BorderSide(color: colorPalette.primaryBorder, width: 1),
  });

  @override
  MaterialTapTargetSize? get tapTargetSize => .shrinkWrap;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      );

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(Size(60, 48));

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(.infinite);

  @override
  WidgetStateProperty<TextStyle?>? get textStyle =>
      WidgetStatePropertyAll(typography.bodyMedium);

  @override
  VisualDensity? get visualDensity => VisualDensity.adaptivePlatformDensity;

  @override
  WidgetStateProperty<Color>? get surfaceTintColor =>
      const WidgetStatePropertyAll<Color>(Colors.transparent);

  @override
  WidgetStateProperty<double?>? get elevation =>
      const WidgetStatePropertyAll(0.0);

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor =>
      WidgetStateMapper<MouseCursor?>({
        WidgetState.disabled: SystemMouseCursors.basic,
        WidgetState.any: SystemMouseCursors.click,
      });

  @override
  WidgetStateProperty<double>? get iconSize =>
      const WidgetStatePropertyAll<double>(18.0);

  @override
  ButtonLayerBuilder? get backgroundBuilder => _backgroundBuilder;

  Widget _backgroundBuilder(
    BuildContext context,
    Set<WidgetState> states,
    Widget? child,
  ) {
    if (child == null) return const SizedBox.shrink();

    return OutlineFocusButtonBorder(
      showBorder: states.contains(WidgetState.focused),
      border: RoundedRectangleBorder(
        side: BorderSide(color: colorPalette.border, width: 1),
        borderRadius: const .all(.circular(16.0)),
      ),
      child: child,
    );
  }
}

class OutlineFocusButtonBorder extends StatelessWidget {
  const OutlineFocusButtonBorder({
    required this.child,
    required this.showBorder,
    required this.border,
    super.key,
  });

  final Widget child;
  final bool showBorder;
  final ShapeBorder border;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _OutlineFocusButtonBorderPainter(
      showBorder: showBorder,
      border: border,
    ),
    child: child,
  );
}

class _OutlineFocusButtonBorderPainter extends CustomPainter {
  _OutlineFocusButtonBorderPainter({
    required bool showBorder,
    required ShapeBorder border,
  }) : _showBorder = showBorder,
       _border = border;

  final bool _showBorder;
  final ShapeBorder _border;

  @override
  void paint(Canvas canvas, Size size) {
    if (!_showBorder) return;

    final rect = Offset.zero & size;

    _border.paint(canvas, rect);
  }

  @override
  bool shouldRepaint(_OutlineFocusButtonBorderPainter oldDelegate) =>
      _showBorder != oldDelegate._showBorder || _border != oldDelegate._border;

  @override
  bool shouldRebuildSemantics(_OutlineFocusButtonBorderPainter oldDelegate) =>
      false;
}

class _IconButtonStandardStyle extends _IconButtonBaseStyle {
  const _IconButtonStandardStyle({
    required super.colorPalette,
    required super.typography,
  });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.muted,
        WidgetState.any: colorPalette.foreground,
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor => WidgetStateMapper<Color?>({
    WidgetState.pressed: colorPalette.foreground.withValues(alpha: .1),
    WidgetState.hovered: colorPalette.foreground.withValues(alpha: .08),
    WidgetState.focused: colorPalette.foreground.withValues(alpha: .1),
  });
}

class _IconButtonBaseStyle extends _UiBaseButtonStyle {
  const _IconButtonBaseStyle({
    required super.colorPalette,
    required super.typography,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStatePropertyAll(colorPalette.card);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.foreground.withValues(alpha: .38),
        WidgetState.any: colorPalette.foreground,
      });

  @override
  WidgetStateProperty<Color?>? get overlayColor => WidgetStateMapper<Color?>({
    WidgetState.pressed: colorPalette.foreground.withValues(alpha: .1),
    WidgetState.hovered: colorPalette.foreground.withValues(alpha: .08),
    WidgetState.focused: colorPalette.foreground.withValues(alpha: .1),
  });

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      const WidgetStatePropertyAll<EdgeInsetsGeometry>(.all(8.0));

  @override
  WidgetStateProperty<Size>? get minimumSize =>
      const WidgetStatePropertyAll<Size>(.square(40.0));

  @override
  WidgetStateProperty<double>? get iconSize =>
      const WidgetStatePropertyAll<double>(24.0);

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      .all(RoundedRectangleBorder(borderRadius: const .all(.circular(18.0))));

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStateMapper<BorderSide?>({
    WidgetState.disabled: BorderSide(color: colorPalette.border, width: 1),
    WidgetState.any: BorderSide(color: colorPalette.borderStrong, width: 1),
  });
}
