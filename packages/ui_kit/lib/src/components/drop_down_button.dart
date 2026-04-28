import 'package:ui_kit/ui.dart';

class UiDropDownButton<T extends Object> extends StatefulWidget {
  const UiDropDownButton({
    super.key,
    this.dropdownMenuEntries,
    this.hintText,
    this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.selectedTrailingIcon,
    this.width,
    this.expandedInsets = .zero,
    this.controller,
    this.menuHeight,
    this.textAlign = .center,
    this.enabled = true,
    this.enableSearch = true,
    this.enableFilter = false,
    this.requestFocusOnTap = true,
    this.selectOnly = false,
    this.showTrailingIcon = true,
    this.initialSelection,
    this.onSelected,
    this.textStyle,
  });

  final List<DropdownMenuEntry<T>>? dropdownMenuEntries;
  final String? hintText;
  final Widget? label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? selectedTrailingIcon;
  final double? width;
  final EdgeInsetsGeometry expandedInsets;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final double? menuHeight;
  final bool enabled;
  final bool enableSearch;
  final bool enableFilter;
  final bool requestFocusOnTap;
  final bool selectOnly;
  final bool showTrailingIcon;
  final T? initialSelection;
  final ValueChanged<T?>? onSelected;
  final TextStyle? textStyle;

  @override
  State<UiDropDownButton<T>> createState() => _UiDropDownButtonState<T>();
}

class _UiDropDownButtonState<T extends Object>
    extends State<UiDropDownButton<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownMenu<T>(
      dropdownMenuEntries: widget.dropdownMenuEntries ?? [],
      label: widget.label,
      hintText: widget.hintText,
      trailingIcon:
          widget.trailingIcon ?? const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon:
          widget.selectedTrailingIcon ??
          const Icon(Icons.keyboard_arrow_up_rounded),
      leadingIcon: widget.leadingIcon,
      width: widget.width,
      expandedInsets: widget.expandedInsets,
      controller: widget.controller,
      menuHeight: widget.menuHeight,
      enabled: widget.enabled,
      textAlign: widget.textAlign,
      enableFilter: widget.enableFilter,
      enableSearch: widget.enableSearch,
      requestFocusOnTap: widget.requestFocusOnTap,
      selectOnly: widget.selectOnly,
      showTrailingIcon: widget.showTrailingIcon,
      initialSelection: widget.initialSelection,
      maxLines: 1,
      onSelected: (value) => widget.onSelected?.call(value),
      textStyle:
          widget.textStyle ??
          theme.appTypography2.m.copyWith(overflow: .ellipsis),
      menuStyle: UiDropDownMenuStyle(palette: theme.colorPalette2),
      inputDecorationTheme: _buildInputDecorationTheme(
        palette: theme.colorPalette2,
        typography: theme.appTypography2,
      ),
    );
  }
}

class UiDropDownMenuStyle extends MenuStyle {
  const UiDropDownMenuStyle({required this.palette});
  final ColorPalette2 palette;

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStatePropertyAll<Color>(palette.card);

  @override
  WidgetStateProperty<double?>? get elevation =>
      const WidgetStatePropertyAll(1.0);

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(.zero);

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(.zero);

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(.infinite);

  @override
  WidgetStateProperty<BorderSide?>? get side =>
      WidgetStatePropertyAll(BorderSide(style: .none));

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: .all(.circular(20.0))),
      );

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor =>
      WidgetStateMapper<MouseCursor>({
        WidgetState.disabled: SystemMouseCursors.basic,
        WidgetState.any: SystemMouseCursors.click,
      });

  @override
  VisualDensity? get visualDensity => .adaptivePlatformDensity;

  @override
  AlignmentGeometry? get alignment => .bottomStart;
}

InputDecorationTheme _buildInputDecorationTheme({
  required ColorPalette2 palette,
  required AppTypography2 typography,
}) {
  final border = OutlineInputBorder(
    borderRadius: const .all(.circular(20.0)),
    borderSide: const BorderSide(style: .none),
  );
  return InputDecorationTheme(
    isCollapsed: true,
    labelStyle: typography.m.copyWith(color: palette.foreground),
    hintStyle: typography.m.copyWith(color: palette.foreground),
    border: border,
    focusedBorder: border,
    enabledBorder: border,
    errorBorder: border,
    focusedErrorBorder: border,
    fillColor: palette.card,
    filled: true,
    contentPadding: const .only(
      left: 20.0,
      right: 12.0,
      top: 12.0,
      bottom: 12.0,
    ),
    isDense: true,
  );
}
