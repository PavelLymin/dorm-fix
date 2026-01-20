import 'package:ui_kit/ui.dart';

enum ItemDividerType { indented, full }

class ItemDivider extends StatelessWidget {
  const ItemDivider._([this.type = .indented]);

  final ItemDividerType type;

  factory ItemDivider.indented() => const ItemDivider._(.indented);
  factory ItemDivider.full() => const ItemDivider._(.full);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.appStyleData;
    final padding = style.groupedListStyle.contentEdgePadding.copyWith(
      top: .0,
      bottom: .0,
    );
    return switch (type) {
      .indented => Padding(
        padding: padding,
        child: const Divider(height: .0, thickness: 1.0),
      ),
      .full => const Divider(height: .0, thickness: 1.0),
    };
  }
}
