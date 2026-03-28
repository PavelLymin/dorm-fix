import 'dart:async';

import 'package:ui_kit/ui.dart';
import 'divider_item.dart';
import 'grouped_list_controller.dart';

part 'grouped_list_item.dart';

class GroupedListItem {
  const GroupedListItem({
    required this.title,
    this.subTitle,
    this.prefixIcon,
    this.content,
    this.onTap,
    this.selectItems,
    this.isSelected = false,
  });

  final UiText title;
  final UiText? subTitle;
  final Icon? prefixIcon;
  final Widget? content;
  final FutureOr<void> Function()? onTap;
  final GroupedListSelection? selectItems;
  final bool isSelected;
}

abstract class GroupedListSelection {
  Enum get initial;
  Map<Enum, String> get items;
  FutureOr<void> onSelect(Enum value);
}

class SelectItem<T extends Enum> implements GroupedListSelection {
  const SelectItem({
    required Map<T, String> items,
    required T initial,
    this.onChange,
  }) : _items = items,
       _initial = initial;

  final Map<T, String> _items;
  final T _initial;
  final FutureOr<void> Function(T)? onChange;

  @override
  Enum get initial => _initial;

  @override
  Map<Enum, String> get items => _items;

  @override
  FutureOr<void> onSelect(Enum value) => onChange?.call(value as T);
}

class GroupedList extends StatefulWidget {
  const GroupedList({
    super.key,
    required this.items,
    required this.divider,
    this.style = const GroupedListStyle(),
  });

  final List<GroupedListItem> items;
  final ItemDivider divider;
  final GroupedListStyle style;

  @override
  State<GroupedList> createState() => _GroupedListState();
}

class _GroupedListState extends State<GroupedList> {
  @override
  Widget build(BuildContext context) {
    final palette = context.colorPalette;
    final style = context.appStyle.style;
    return DecoratedBox(
      position: .foreground,
      decoration: BoxDecoration(
        borderRadius: .all(.circular(widget.style.borderRadius)),
        border: .all(width: style.borderWidth, color: palette.border),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const .all(.0),
          itemCount: widget.items.length,
          itemBuilder: (_, index) {
            final item = widget.items[index];
            final isFirst = index == 0;
            final isLast = index == widget.items.length - 1;
            return _Item(
              width: constraints.maxWidth,
              item: item,
              style: widget.style,
              borderRadius: .vertical(
                top: isFirst ? .circular(widget.style.borderRadius) : .zero,
                bottom: isLast ? .circular(widget.style.borderRadius) : .zero,
              ),
              isInitial: item.isSelected,
            );
          },
          separatorBuilder: (_, _) => widget.divider,
        ),
      ),
    );
  }
}

class GroupedListStyle {
  const GroupedListStyle({
    this.iconSize = 24.0,
    this.contentEdgePadding = const .all(16.0),
    this.spacing = 4.0,
    this.borderRadius = 32.0,
  });

  final EdgeInsets contentEdgePadding;
  final double spacing;
  final double iconSize;
  final double borderRadius;

  GroupedListStyle copyWith({
    TextStyle? titleStyle,
    TextStyle? dataStyle,
    EdgeInsets? contentEdgePadding,
    double? spacing,
    double? iconSize,
    double? borderRadius,
    AppWidgetStateMap<Color>? overlayColor,
    Color? itemColor,
    Color? selectItemColor,
  }) => GroupedListStyle(
    contentEdgePadding: contentEdgePadding ?? this.contentEdgePadding,
    spacing: spacing ?? this.spacing,
    iconSize: iconSize ?? this.iconSize,
    borderRadius: borderRadius ?? this.borderRadius,
  );

  AppWidgetStateMap<Color> overlayColor(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return AppWidgetStateMap<Color>({
      WidgetState.selected: palette.foreground.withValues(alpha: .2),
      WidgetState.disabled: palette.muted.withValues(alpha: .1),
      WidgetState.any: palette.foreground.withValues(alpha: .1),
    });
  }

  AppWidgetStateMap<Color> itemColor(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return AppWidgetStateMap<Color>({
      WidgetState.selected: palette.secondary,
      WidgetState.disabled: palette.muted,
      WidgetState.any: palette.card,
    });
  }

  Color iconColor(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    return palette.foreground;
  }
}
