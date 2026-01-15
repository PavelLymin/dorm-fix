import 'dart:async';

import 'package:ui_kit/ui.dart';
import 'divider_item.dart';
import 'grouped_list_controller.dart';

part 'grouped_list_item.dart';

class GroupedListItem<T extends Enum> {
  const GroupedListItem({
    required this.title,
    this.data,
    this.prefixIcon,
    this.content,
    this.onTap,
    this.selectItems,
    this.isSelected = false,
  });

  final String title;
  final String? data;
  final IconData? prefixIcon;
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
  late double _height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _height = height(widget.style);
  }

  double height(GroupedListStyle style) {
    final title = style.titleStyle(context);
    final data = style.dataStyle(context);
    final titleHeight = title.fontSize! * title.height!;
    final dataHeight = data.fontSize! * data.height!;
    final itemPadding = style.spacing;
    final textHeight = (titleHeight + dataHeight).ceil();
    final contentHeight = textHeight > style.iconSize
        ? textHeight
        : style.iconSize;

    return contentHeight + itemPadding + style.contentEdgePadding.vertical;
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return DecoratedBox(
      position: .foreground,
      decoration: BoxDecoration(
        borderRadius: .all(.circular(widget.style.borderRadius)),
        border: .all(
          width: context.appStyle.style.borderWidth,
          color: colorPalette.border,
        ),
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
            return SizedBox(
              height: _height,
              child: _Item<T>(
                width: constraints.maxWidth,
                item: item,
                style: widget.style,
                borderRadius: .vertical(
                  top: isFirst ? .circular(widget.style.borderRadius) : .zero,
                  bottom: isLast ? .circular(widget.style.borderRadius) : .zero,
                ),
                isInitial: item.isSelected,
              ),
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

  TextStyle titleStyle(BuildContext context) =>
      context.typography.bodyLarge.copyWith(color: context.palette.foreground);

  TextStyle dataStyle(BuildContext context) => context.typography.bodyMedium
      .copyWith(color: context.palette.mutedForeground);

  AppWidgetStateMap<Color> overlayColor(BuildContext context) =>
      AppWidgetStateMap<Color>({
        WidgetState.selected: context.palette.foreground.withValues(alpha: .2),
        WidgetState.pressed: context.palette.foreground.withValues(alpha: .2),
        WidgetState.hovered: context.palette.foreground.withValues(alpha: .1),
        WidgetState.focused: context.palette.foreground.withValues(alpha: 0),
      });

  AppWidgetStateMap<Color> itemColor(BuildContext context) =>
      AppWidgetStateMap<Color>({
        WidgetState.selected: context.palette.secondary,
        WidgetState.disabled: context.palette.muted,
        WidgetState.any: context.palette.card,
      });
}
