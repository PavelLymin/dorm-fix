import 'package:ui_kit/ui.dart';

class GroupedListItem {
  const GroupedListItem({required this.title, required this.data, this.onTap});

  final UiText title;
  final UiText data;
  final Function()? onTap;
}

class GroupedList extends StatelessWidget {
  const GroupedList({
    super.key,
    required this.items,
    this.itemPadding = AppPadding.allMedium,
    this.borderRadius = const Radius.circular(16),
  });

  final List<GroupedListItem> items;
  final EdgeInsets itemPadding;
  final Radius borderRadius;

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (_, index) {
      final item = items[index];
      final isFirst = index == 0;
      final isLast = index == items.length - 1;
      return _PersonalDataCard(
        title: item.title,
        data: item.data,
        itemPadding: itemPadding,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? borderRadius : Radius.zero,
          bottom: isLast ? borderRadius : Radius.zero,
        ),
        onTap: item.onTap,
      );
    },
    separatorBuilder: (_, _) => const Divider(height: 0),
    itemCount: items.length,
  );
}

class _PersonalDataCard extends StatelessWidget {
  const _PersonalDataCard({
    required this.title,
    required this.data,
    required this.itemPadding,
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.onTap,
  });

  final UiText title;
  final UiText data;
  final EdgeInsets itemPadding;
  final BorderRadius borderRadius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    borderRadius: borderRadius,
    child: InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Padding(
        padding: itemPadding,
        child: Column(
          spacing: 4,
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [title, data],
        ),
      ),
    ),
  );
}
