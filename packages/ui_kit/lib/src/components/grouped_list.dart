import 'package:ui_kit/src/theme/style_data.dart';
import 'package:ui_kit/ui.dart';

class GroupedListItem {
  const GroupedListItem({
    required this.title,
    this.data,
    this.content,
    this.onTap,
  });

  final UiText title;
  final UiText? data;
  final Widget? content;
  final void Function()? onTap;
}

class GroupedList extends StatelessWidget {
  const GroupedList({
    super.key,
    required this.items,
    this.itemPadding,
    this.borderRadius = const .circular(16),
    this.color,
  });

  final List<GroupedListItem> items;
  final EdgeInsets? itemPadding;
  final Radius borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = context.styles.groupedListStyle;

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: .vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const .all(0),
      itemBuilder: (_, index) {
        final item = items[index];
        final isFirst = index == 0;
        final isLast = index == items.length - 1;
        return _PersonalDataCard(
          item: item,
          itemPadding: itemPadding ?? style.itemPadding,
          color: color,
          borderRadius: .vertical(
            top: isFirst ? style.borderRadius : .zero,
            bottom: isLast ? style.borderRadius : .zero,
          ),
        );
      },
      separatorBuilder: (_, _) => const Divider(height: 0, thickness: 1),
      itemCount: items.length,
    );
  }
}

class _PersonalDataCard extends StatelessWidget {
  const _PersonalDataCard({
    required this.item,
    required this.itemPadding,
    required this.color,
    this.borderRadius = const BorderRadius.all(Radius.zero),
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
        child: Row(
          crossAxisAlignment: .center,
          mainAxisAlignment: .spaceBetween,
          children: [
            Padding(
              padding: itemPadding,
              child: Column(
                spacing: 4,
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [item.title, item.data ?? const SizedBox.shrink()],
              ),
            ),
            Padding(
              padding: .only(right: itemPadding.right),
              child: item.content ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupedListStyle {
  const GroupedListStyle({
    required this.overlayColor,
    required this.itemColor,
    this.itemPadding = AppPadding.allMedium,
    this.borderRadius = const .circular(16),
  });

  final EdgeInsets itemPadding;
  final Radius borderRadius;
  final AppWidgetStateMap<Color> overlayColor;
  final Color itemColor;

  factory GroupedListStyle.defaultStyle(BuildContext context) {
    final primaryForeground = Theme.of(context).colorPalette.primaryForeground;
    final secondary = Theme.of(context).colorPalette.secondary;

    return GroupedListStyle(
      overlayColor: AppWidgetStateMap<Color>({
        WidgetState.pressed: primaryForeground.withValues(alpha: 0.2),
        WidgetState.hovered: primaryForeground.withValues(alpha: 0.1),
        WidgetState.focused: primaryForeground.withValues(alpha: 0),
      }),
      itemColor: secondary,
    );
  }
}
