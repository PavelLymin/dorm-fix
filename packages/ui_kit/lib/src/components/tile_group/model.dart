part of 'tile_group.dart';

class TileGroupItem {
  const TileGroupItem({
    required this.title,
    this.subTitle,
    this.sufixIcon,
    this.prefixIcon,
    this.onTap,
    this.initial,
    this.selectItem,
  });

  final String title;
  final String? subTitle;
  final Icon? sufixIcon;
  final Icon? prefixIcon;
  final void Function()? onTap;
  final int? initial;
  final TileSelectItem? selectItem;
}

class TileSelectItem {
  const TileSelectItem({required this.items, required this.onSelect});

  final Map<int, String> items;
  final void Function(int) onSelect;
}
