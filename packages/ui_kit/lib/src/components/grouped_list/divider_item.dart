import 'package:ui_kit/ui.dart';

enum ItemDividerType { indented, full }

class ItemDivider extends StatelessWidget {
  const ItemDivider._([this.type = .indented]);

  final ItemDividerType type;

  factory ItemDivider.indented() => const ItemDivider._(.indented);
  factory ItemDivider.full() => const ItemDivider._(.full);

  @override
  Widget build(BuildContext context) {
    final style = context.appStyle;
    final appPadding = style.groupedListStyle.contentEdgePadding;

    return switch (type) {
      .indented => Divider(
        height: 0.0,
        thickness: 1.0,
        indent: appPadding.left,
        endIndent: appPadding.right,
      ),
      .full => const Divider(height: 0.0, thickness: 1.0),
    };
  }
}
