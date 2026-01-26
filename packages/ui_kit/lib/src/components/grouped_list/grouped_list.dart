import 'dart:async';

import 'package:ui_kit/ui.dart';
import 'divider_item.dart';
import 'grouped_list_controller.dart';

part 'grouped_list_item.dart';

class GroupedListItem<T extends Enum> {
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
  final void Function()? onTap;
  final SelectItem<T>? selectItems;
  final bool isSelected;
}

class SelectItem<T extends Enum> {
  const SelectItem({required this.items, required this.initial, this.onChange});

  final Map<String, T> items;
  final T initial;
  final FutureOr<void> Function(T)? onChange;
}

class GroupedList<T extends Enum> extends StatefulWidget {
  const GroupedList({
    super.key,
    required this.items,
    required this.divider,
    this.style = const GroupedListStyle(),
  });

  final List<GroupedListItem<T>> items;
  final ItemDivider divider;
  final GroupedListStyle style;

  @override
  State<GroupedList> createState() => _GroupedListState<T>();
}

class _GroupedListState<T extends Enum> extends State<GroupedList<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
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
            return _Item<T>(
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
