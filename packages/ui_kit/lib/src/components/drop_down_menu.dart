import 'package:flutter/services.dart';
import 'package:ui_kit/ui.dart';

class UiDropDownMenu<T extends Object> extends StatefulWidget {
  const UiDropDownMenu({
    super.key,
    this.enabled = true,
    this.width = 144,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.showTrailingIcon = true,
    this.trailingIconFocusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.keyboardType,
    this.textStyle,
    this.textAlign = .start,
    this.inputDecorationTheme,
    this.decorationBuilder,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.focusNode,
    this.requestFocusOnTap,
    this.selectOnly = false,
    this.expandedInsets,
    this.filterCallback,
    this.searchCallback,
    this.alignmentOffset,
    required this.dropdownMenuEntries,
    this.inputFormatters,
    this.closeBehavior = .all,
    this.maxLines = 1,
    this.textInputAction,
    this.cursorHeight,
    this.restorationId,
    this.menuController,
  });
  final bool enabled;
  final double? width;
  final double? menuHeight;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool showTrailingIcon;
  final FocusNode? trailingIconFocusNode;
  final Widget? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? selectedTrailingIcon;
  final bool enableFilter;
  final bool enableSearch;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final Object? inputDecorationTheme;
  final InputDecoration Function(BuildContext, MenuController)?
  decorationBuilder;
  final UiMenuStyle? menuStyle;
  final TextEditingController? controller;
  final T? initialSelection;
  final void Function(T?)? onSelected;
  final FocusNode? focusNode;
  final bool? requestFocusOnTap;
  final bool selectOnly;
  final EdgeInsetsGeometry? expandedInsets;
  final List<DropdownMenuEntry<T>> Function(List<DropdownMenuEntry<T>>, String)?
  filterCallback;
  final int? Function(List<DropdownMenuEntry<T>>, String)? searchCallback;
  final Offset? alignmentOffset;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final List<TextInputFormatter>? inputFormatters;
  final DropdownMenuCloseBehavior closeBehavior;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final double? cursorHeight;
  final String? restorationId;
  final MenuController? menuController;

  @override
  State<UiDropDownMenu<T>> createState() => _UiDropDownMenuState<T>();
}

class _UiDropDownMenuState<T extends Object> extends State<UiDropDownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    final uiStyle = UiMenuStyle(palette: palette, typography: typography);

    final style = uiStyle.merge(widget.menuStyle);

    return DropdownMenu<T>(
      enabled: widget.enabled,
      width: widget.width,
      menuHeight: widget.menuHeight,
      leadingIcon: widget.leadingIcon,
      trailingIcon: widget.trailingIcon,
      showTrailingIcon: widget.showTrailingIcon,
      trailingIconFocusNode: widget.trailingIconFocusNode,
      label: widget.label,
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      selectedTrailingIcon: widget.selectedTrailingIcon,
      enableFilter: widget.enableFilter,
      enableSearch: widget.enableSearch,
      keyboardType: widget.keyboardType,
      textStyle: widget.textStyle,
      textAlign: widget.textAlign,
      inputDecorationTheme: widget.inputDecorationTheme,
      decorationBuilder: widget.decorationBuilder,
      menuStyle: style,
      controller: widget.controller,
      initialSelection: widget.initialSelection,
      onSelected: widget.onSelected,
      focusNode: widget.focusNode,
      requestFocusOnTap: widget.requestFocusOnTap,
      selectOnly: widget.selectOnly,
      expandedInsets: widget.expandedInsets,
      filterCallback: widget.filterCallback,
      searchCallback: widget.searchCallback,
      alignmentOffset: widget.alignmentOffset,
      dropdownMenuEntries: widget.dropdownMenuEntries,
      inputFormatters: widget.inputFormatters,
      closeBehavior: widget.closeBehavior,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      cursorHeight: widget.cursorHeight,
      restorationId: widget.restorationId,
      menuController: widget.menuController,
    );
  }
}

class UiMenuStyle extends MenuStyle {
  const UiMenuStyle({required this.palette, required this.typography});

  final ColorPalette palette;
  final AppTypography typography;

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      AppWidgetStateMap<Color?>({
        WidgetState.selected: palette.secondary,
        WidgetState.disabled: palette.muted,
        WidgetState.any: palette.card,
      });

  @override
  WidgetStateProperty<Color?>? get shadowColor => AppWidgetStateMap<Color?>({
    WidgetState.pressed: palette.foreground.withValues(alpha: .2),
    WidgetState.hovered: palette.foreground.withValues(alpha: .1),
    WidgetState.focused: palette.foreground.withValues(alpha: .1),
  });

  @override
  WidgetStateProperty<double?>? get elevation => .all(2.0);

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding => .all(.zero);

  @override
  WidgetStateProperty<Size?>? get minimumSize => .all(.fromHeight(48.0));

  @override
  WidgetStateProperty<Size?>? get maximumSize => .all(.fromHeight(256.0));

  @override
  WidgetStateProperty<BorderSide?>? get side =>
      .all(BorderSide(color: palette.borderStrong, width: 1));

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      .all(RoundedRectangleBorder(borderRadius: const .all(.circular(16.0))));

  @override
  AlignmentGeometry? get alignment => .bottomLeft.add(.xy(0, 0.2));
}
