import 'package:ui_kit/ui.dart';

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
  });

  final String title;
  final String? data;
  final IconData? prefixIcon;
  final Widget? content;
  final void Function()? onTap;
  final SelectItem<T>? selectItems;
}

class SelectItem<T extends Enum> {
  const SelectItem({required this.items, required this.initial, this.onChange});

  final Map<String, T> items;
  final T initial;
  final ValueChanged<T>? onChange;
}

class GroupedList<T extends Enum> extends StatefulWidget {
  const GroupedList({super.key, required this.items, this.style});

  final List<GroupedListItem<T>> items;
  final GroupedListStyle? style;

  @override
  State<GroupedList> createState() => _GroupedListState<T>();
}

class _GroupedListState<T extends Enum> extends State<GroupedList<T>> {
  late final double _height;
  late final GroupedListStyle _style;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = widget.style ?? context.styles.groupedListStyle;
    _height = height(_style);
  }

  double height(GroupedListStyle style) {
    final titleHeight = style.titleStyle.fontSize! * style.titleStyle.height!;
    final dataHeight = style.dataStyle.fontSize! * style.dataStyle.height!;
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
        borderRadius: .all(.circular(_style.borderRadius)),
        border: .all(
          width: context.styles.appStyle.borderWidth,
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
                style: _style,
                borderRadius: .vertical(
                  top: isFirst ? .circular(_style.borderRadius) : .zero,
                  bottom: isLast ? .circular(_style.borderRadius) : .zero,
                ),
              ),
            );
          },
          separatorBuilder: (_, _) => Padding(
            padding: _style.contentEdgePadding.copyWith(top: .0, bottom: .0),
            child: const Divider(height: .0, thickness: 1.0),
          ),
        ),
      ),
    );
  }
}

class GroupedListStyle {
  const GroupedListStyle({
    required this.titleStyle,
    required this.dataStyle,
    required this.overlayColor,
    required this.itemColor,
    this.iconSize = 24.0,
    this.contentEdgePadding = const .all(16.0),
    this.spacing = 4.0,
    this.borderRadius = 32.0,
  });

  final TextStyle titleStyle;
  final TextStyle dataStyle;
  final EdgeInsets contentEdgePadding;
  final double spacing;
  final double iconSize;
  final double borderRadius;
  final AppWidgetStateMap<Color> overlayColor;
  final Color itemColor;

  GroupedListStyle copyWith({
    TextStyle? titleStyle,
    TextStyle? dataStyle,
    EdgeInsets? contentEdgePadding,
    double? spacing,
    double? iconSize,
    double? borderRadius,
    AppWidgetStateMap<Color>? overlayColor,
    Color? itemColor,
  }) => GroupedListStyle(
    titleStyle: titleStyle ?? this.titleStyle,
    dataStyle: dataStyle ?? this.dataStyle,
    contentEdgePadding: contentEdgePadding ?? this.contentEdgePadding,
    spacing: spacing ?? this.spacing,
    iconSize: iconSize ?? this.iconSize,
    borderRadius: borderRadius ?? this.borderRadius,
    overlayColor: overlayColor ?? this.overlayColor,
    itemColor: itemColor ?? this.itemColor,
  );

  factory GroupedListStyle.defaultStyle(BuildContext context) {
    final foreground = Theme.of(context).colorPalette.foreground;
    final colorPalette = Theme.of(context).colorPalette;
    final typography = Theme.of(context).appTypography;

    return GroupedListStyle(
      overlayColor: AppWidgetStateMap<Color>({
        WidgetState.pressed: foreground.withValues(alpha: .2),
        WidgetState.hovered: foreground.withValues(alpha: .1),
        WidgetState.focused: foreground.withValues(alpha: 0),
      }),
      titleStyle: typography.bodyLarge,
      dataStyle: typography.bodyMedium.copyWith(
        color: colorPalette.mutedForeground,
      ),
      itemColor: colorPalette.card,
    );
  }
}
