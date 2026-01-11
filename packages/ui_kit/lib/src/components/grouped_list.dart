import 'package:ui_kit/ui.dart';

class GroupedListItem {
  const GroupedListItem({
    required this.title,
    this.icon,
    this.data,
    this.content,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final String? data;
  final Widget? content;
  final void Function()? onTap;
}

class GroupedList extends StatefulWidget {
  const GroupedList({
    super.key,
    required this.items,
    this.borderRadius = const .circular(16.0),
    this.color,
  });

  final List<GroupedListItem> items;
  final Radius borderRadius;
  final Color? color;

  @override
  State<GroupedList> createState() => _GroupedListState();
}

class _GroupedListState extends State<GroupedList> {
  late final double _height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _height = height(context.styles.groupedListStyle);
  }

  double height(GroupedListStyle style) {
    final titleHeight = style.titleStyle.fontSize! * style.titleStyle.height!;
    final dataHeight = style.dataStyle.fontSize! * style.dataStyle.height!;
    final itemPadding = style.contentEdgeSpacing * 2;
    final textHeight = (titleHeight + dataHeight).ceil();

    final contentHeight = textHeight > style.iconSize
        ? textHeight
        : style.iconSize;

    return contentHeight + itemPadding + style.contentSpacingColumn;
  }

  @override
  Widget build(BuildContext context) {
    final style = context.styles.groupedListStyle;

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: .vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const .all(.0),
      itemBuilder: (_, index) {
        final item = widget.items[index];
        final isFirst = index == 0;
        final isLast = index == widget.items.length - 1;
        return SizedBox(
          height: _height,
          child: _Item(
            item: item,
            itemPadding: .all(style.contentEdgeSpacing),
            color: widget.color,
            borderRadius: .vertical(
              top: isFirst ? style.borderRadius : .zero,
              bottom: isLast ? style.borderRadius : .zero,
            ),
          ),
        );
      },
      separatorBuilder: (_, _) => Padding(
        padding: .symmetric(horizontal: style.contentEdgeSpacing),
        child: const Divider(height: .0, thickness: 1.0),
      ),
      itemCount: widget.items.length,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.item,
    required this.itemPadding,
    required this.color,
    this.borderRadius = const .all(.zero),
  });

  final GroupedListItem item;
  final EdgeInsets itemPadding;
  final BorderRadius borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = context.styles.groupedListStyle;

    return Material(
      color: style.itemColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: item.onTap,
        overlayColor: style.overlayColor,
        child: Padding(
          padding: itemPadding,
          child: Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: style.contentSpacingRow,
                crossAxisAlignment: .center,
                mainAxisAlignment: .start,
                children: [
                  Icon(item.icon, size: style.iconSize),
                  Column(
                    spacing: style.contentSpacingColumn,
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Text(item.title, style: style.titleStyle, softWrap: true),
                      item.data != null
                          ? Text(
                              item.data!,
                              style: style.dataStyle,
                              softWrap: true,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              item.content ?? const SizedBox.shrink(),
            ],
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
    this.contentEdgeSpacing = 16.0,
    this.contentSpacingRow = 16.0,
    this.contentSpacingColumn = 4.0,
    this.borderRadius = const .circular(16.0),
  });

  final TextStyle titleStyle;
  final TextStyle dataStyle;
  final double contentEdgeSpacing;
  final double contentSpacingRow;
  final double contentSpacingColumn;
  final double iconSize;
  final Radius borderRadius;
  final AppWidgetStateMap<Color> overlayColor;
  final Color itemColor;

  factory GroupedListStyle.defaultStyle(BuildContext context) {
    final primaryForeground = Theme.of(context).colorPalette.primaryForeground;
    final colorPalette = Theme.of(context).colorPalette;
    final typography = Theme.of(context).appTypography;

    return GroupedListStyle(
      overlayColor: AppWidgetStateMap<Color>({
        WidgetState.pressed: primaryForeground.withValues(alpha: 0.2),
        WidgetState.hovered: primaryForeground.withValues(alpha: 0.1),
        WidgetState.focused: primaryForeground.withValues(alpha: 0),
      }),
      titleStyle: typography.bodyLarge,
      dataStyle: typography.bodyMedium.copyWith(color: colorPalette.primary),
      itemColor: colorPalette.secondary,
    );
  }
}
