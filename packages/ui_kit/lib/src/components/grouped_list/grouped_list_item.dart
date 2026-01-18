part of 'grouped_list.dart';

class _Item<T extends Enum> extends StatefulWidget {
  const _Item({
    required this.width,
    required this.item,
    required this.style,
    required this.borderRadius,
    this.isInitial = false,
  });

  final double width;
  final GroupedListItem<T> item;
  final GroupedListStyle style;
  final BorderRadius borderRadius;
  final bool isInitial;

  @override
  State<_Item<T>> createState() => _ItemState<T>();
}

class _ItemState<T extends Enum> extends State<_Item<T>>
    with _ItemMixinMenuLink<T> {
  @override
  Widget build(BuildContext context) {
    return WidgetStateBuilder(
      isSelected: widget.isInitial,
      builder: (context, states, _) => TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: .zero,
          textStyle: widget.style.titleStyle(context),
          foregroundColor: widget.style.titleStyle(context).color,
          backgroundColor: widget.style.itemColor(context).resolve(states),
          overlayColor: widget.style.overlayColor(context).resolve(states),
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          iconColor: widget.style.iconColor(context),
          iconSize: widget.style.iconSize,
        ),
        child: CompositedTransformTarget(
          link: _layerLink,
          child: _ItemContent<T>(
            style: widget.style,
            item: widget.item,
            hasSelect: _hasSelect,
            hasData: _hasData,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}

class _ItemContent<T extends Enum> extends StatelessWidget {
  const _ItemContent({
    super.key,
    required this.style,
    required this.item,
    required this.hasSelect,
    required this.hasData,
    required this.controller,
  });

  final GroupedListStyle style;
  final GroupedListItem<T> item;
  final bool hasSelect;
  final bool hasData;
  final SelectItemsController<T>? controller;

  @override
  Widget build(BuildContext context) => Padding(
    padding: style.contentEdgePadding,
    child: Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        if (item.prefixIcon != null) ...[
          Icon(item.prefixIcon),
          const SizedBox(width: 8.0),
        ],
        Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: style.spacing,
          children: [
            Text(item.title, softWrap: true),
            if (hasSelect)
              ValueListenableBuilder<T>(
                valueListenable: controller!,
                builder: (_, value, _) => Text(
                  value.toString(),
                  style: style.dataStyle(context),
                  softWrap: true,
                ),
              ),
            if (hasData)
              Text(item.data!, style: style.dataStyle(context), softWrap: true),
          ],
        ),
        const Spacer(),
        if (item.content != null) item.content!,
      ],
    ),
  );
}

mixin _ItemMixinMenuLink<T extends Enum> on State<_Item<T>> {
  final _layerLink = LayerLink();
  SelectItemsController<T>? _controller;
  OverlayEntry? _overlayEntry;
  bool get isDisabled => widget.item.onTap == null;
  SelectItem<T>? get selectItems => widget.item.selectItems;
  bool get _hasSelect => selectItems != null && selectItems!.items.isNotEmpty;
  bool get _hasData => !_hasSelect && widget.item.data != null;
  double get widthMenu => widget.width * .6;

  @override
  void initState() {
    super.initState();
    if (_hasSelect) {
      _controller = SelectItemsController<T>(
        selectItems!.initial,
        selectItems!,
        hide,
      );
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
    _overlayEntry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: widthMenu,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(-widget.style.contentEdgePadding.left, 4.0),
          targetAnchor: .bottomRight,
          followerAnchor: .topRight,
          child: GroupedList(
            items: _controller!.createItems(),
            divider: .full(),
            style: widget.style.copyWith(
              contentEdgePadding: AppPadding.symmetricIncrement(
                horizontal: 2,
                vertical: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void onTap() {
    if (_hasSelect) {
      show();
    } else {
      widget.item.onTap?.call();
    }
  }
}
