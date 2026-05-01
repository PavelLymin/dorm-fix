import 'package:ui_kit/ui.dart';

enum ButtonVariant { filledPrimary, filledSecondary, icon }

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

  UiButton.filledSecondary({
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
  }) : variant = .filledSecondary,
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
    final colors = theme.colorPalette2;
    final typography = theme.appTypography2;

    return switch (variant) {
      ButtonVariant.filledPrimary => _FilledButtonPrimaryStyle(
        colorPalette: colors,
        typography: typography,
      ),
      ButtonVariant.filledSecondary => _FilledButtonSecondaryStyle(
        colorPalette: colors,
        typography: typography,
      ),
      ButtonVariant.icon => _IconButtonBaseStyle(
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
            ?icon,
            if (icon != null && label != null) const SizedBox(width: 8),
            if (label != null) Flexible(child: label!),
          ]
        : [
            if (label != null) Flexible(child: label!),
            if (icon != null && label != null) const SizedBox(width: 8),
            ?icon,
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
        WidgetState.disabled: colorPalette.background,
        WidgetState.any: colorPalette.foregroundAccent,
      });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.buttonDisabled,
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

class _FilledButtonSecondaryStyle extends _UiBaseButtonStyle {
  const _FilledButtonSecondaryStyle({
    required super.colorPalette,
    required super.typography,
  });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      .all(colorPalette.foreground);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      .all(colorPalette.buttonSecondary);

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

  final ColorPalette2 colorPalette;
  final AppTypography2 typography;

  @override
  AlignmentGeometry? get alignment => .center;

  @override
  Duration? get animationDuration => const Duration(milliseconds: 200);

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: .all(.circular(20.0))),
      );

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStateMapper<BorderSide?>({
    WidgetState.any: const BorderSide(style: .none),
  });

  @override
  MaterialTapTargetSize? get tapTargetSize => .shrinkWrap;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      );

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(Size(60, 48));

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(.infinite);

  @override
  WidgetStateProperty<TextStyle?>? get textStyle => WidgetStatePropertyAll(
    typography.m.copyWith(color: colorPalette.foregroundAccent),
  );

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

    return child;
  }
}

class _IconButtonBaseStyle extends _UiBaseButtonStyle {
  const _IconButtonBaseStyle({
    required super.colorPalette,
    required super.typography,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.disabled,
        WidgetState.any: colorPalette.card,
      });

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateMapper<Color?>({
        WidgetState.disabled: colorPalette.disabledIcon,
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
      const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: .all(.circular(20.0))),
      );

  @override
  WidgetStateProperty<BorderSide?>? get side =>
      const WidgetStateMapper<BorderSide?>({
        WidgetState.any: BorderSide(style: .none),
      });
}
