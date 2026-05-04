import 'package:ui_kit/ui.dart';
import 'item.dart';
part 'model.dart';

class TileGroup extends StatefulWidget {
  const TileGroup({super.key, required this.items});

  final List<TileGroupItem> items;

  @override
  State<TileGroup> createState() => _TileGroupState();
}

class _TileGroupState extends State<TileGroup> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: .zero,
        itemCount: widget.items.length,
        itemBuilder: (_, index) {
          final item = widget.items[index];
          return Item(
            item: item,
            isInitial: item.initial == index,
            isFirst: index == 0,
            isLast: index == widget.items.length - 1,
            constraints: constraints,
          );
        },
      ),
    );
  }
}
