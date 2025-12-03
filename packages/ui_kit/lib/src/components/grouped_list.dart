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
    this.itemPadding = AppPadding.allMedium,
    this.borderRadius = const .circular(16),
    this.color,
  });

  final List<GroupedListItem> items;
  final EdgeInsets itemPadding;
  final Radius borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const .all(0),
    itemBuilder: (_, index) {
      final item = items[index];
      final isFirst = index == 0;
      final isLast = index == items.length - 1;
      return _PersonalDataCard(
        item: item,
        itemPadding: itemPadding,
        color: color,
        borderRadius: .vertical(
          top: isFirst ? borderRadius : .zero,
          bottom: isLast ? borderRadius : .zero,
        ),
      );
    },
    separatorBuilder: (_, _) => const Divider(height: 0),
    itemCount: items.length,
  );
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
  Widget build(BuildContext context) => Material(
    color: color,
    borderRadius: borderRadius,
    child: InkWell(
      borderRadius: borderRadius,
      onTap: item.onTap,
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
            padding: EdgeInsets.only(right: itemPadding.right),
            child: item.content ?? const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}
