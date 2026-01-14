part of 'grouped_list.dart';

class _Item<T extends Enum> extends StatefulWidget {
  const _Item({
    required this.width,
    required this.item,
    required this.style,
    required this.borderRadius,
  });

  final double width;
  final GroupedListItem<T> item;
  final GroupedListStyle style;
  final BorderRadius borderRadius;

  @override
  State<_Item<T>> createState() => _ItemState<T>();
}

class _ItemState<T extends Enum> extends State<_Item<T>>
    with _ItemMixinMenuLink<T> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.style.itemColor,
      borderRadius: widget.borderRadius,
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: onTap,
        overlayColor: widget.style.overlayColor,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Padding(
            padding: widget.style.contentEdgePadding,
            child: Row(
              crossAxisAlignment: .center,
              mainAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                if (widget.item.prefixIcon != null) ...[
                  Icon(widget.item.prefixIcon, size: widget.style.iconSize),
                  const SizedBox(width: 8.0),
                ],
                Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  spacing: widget.style.spacing,
                  children: [
                    Text(
                      widget.item.title,
                      style: widget.style.titleStyle,
                      softWrap: true,
                    ),
                    if (_hasSubItems)
                      ValueListenableBuilder<T>(
                        valueListenable: _controller!,
                        builder: (_, value, _) {
                          return Text(
                            value.name,
                            style: widget.style.dataStyle,
                            softWrap: true,
                          );
                        },
                      ),
                    if (!_hasSubItems && widget.item.data != null)
                      Text(
                        widget.item.data!,
                        style: widget.style.dataStyle,
                        softWrap: true,
                      ),
                  ],
                ),
                const Spacer(),
                if (widget.item.content != null) widget.item.content!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin _ItemMixinMenuLink<T extends Enum> on State<_Item<T>> {
  final _layerLink = LayerLink();
  late final bool _hasSubItems;
  late final List<GroupedListItem<T>> _items;
  GroupedListController<T>? _controller;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    final selectItems = widget.item.selectItems;
    _hasSubItems = selectItems != null && selectItems.items.isNotEmpty;

    if (_hasSubItems) {
      _items = selectItems!.items.entries
          .map(
            (e) => GroupedListItem<T>(
              title: e.key,
              onTap: () => onTapSelect(e.value, selectItems),
            ),
          )
          .toList();

      _controller = GroupedListController<T>(selectItems.initial);
    }
  }

  @override
  void dispose() {
    hide();
    _controller?.dispose();
    super.dispose();
  }

  void show() {
    hide();
    Overlay.of(context).insert(
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          width: widget.width * 0.6,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(-widget.style.contentEdgePadding.left, 4.0),
            targetAnchor: .bottomRight,
            followerAnchor: .topRight,
            child: GroupedList(
              items: _items,
              style: widget.style.copyWith(
                contentEdgePadding: const .symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap() {
    if (_hasSubItems) {
      show();
    } else {
      widget.item.onTap?.call();
    }
  }

  void onTapSelect(T value, SelectItem<T> item) {
    _controller!.value = value;
    item.onChange?.call(value);
    hide();
  }

  void hide() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
