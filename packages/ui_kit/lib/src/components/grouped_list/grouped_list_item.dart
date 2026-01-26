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
    with
        SingleTickerProviderStateMixin,
        _ItemStateMixin,
        _ItemMixinMenuLink<T> {
  @override
  void initState() {
    super.initState();
    _initStates();
    if (_hasSelect) {
      _initSelectItems();
      _initAnimation(this);
    }
  }

  @override
  void didUpdateWidget(covariant _Item<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateStates();
  }

  @override
  void dispose() {
    hide();
    _selectItemsController?.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: _statesController,
      onPressed: onTap,
      style: ButtonStyle(
        padding: .all(.zero),
        tapTargetSize: .shrinkWrap,
        backgroundColor: widget.style.itemColor(context),
        shape: .all(RoundedRectangleBorder(borderRadius: widget.borderRadius)),
        iconColor: .all(widget.style.iconColor(context)),
        iconSize: .all(widget.style.iconSize),
      ),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: _ItemContent<T>(
          style: widget.style,
          item: widget.item,
          hasSelect: _hasSelect,
          hasData: _hasSubTitle,
          controller: _selectItemsController,
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
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    return Padding(
      padding: style.contentEdgePadding,
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          if (item.prefixIcon != null) ...[
            item.prefixIcon!,
            const SizedBox(width: 8.0),
          ],
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: style.spacing,
            children: [
              item.title,
              if (hasSelect)
                ValueListenableBuilder<T>(
                  valueListenable: controller!,
                  builder: (_, value, _) => UiText.bodyMedium(
                    value.toString(),
                    color: palette.mutedForeground,
                  ),
                ),
              if (hasData) item.subTitle!,
            ],
          ),
          const Spacer(),
          if (item.content != null) item.content!,
        ],
      ),
    );
  }
}

mixin _ItemStateMixin<T extends Enum> on State<_Item<T>> {
  late final WidgetStatesController _statesController;
  bool get _isDisabled => widget.item.onTap == null;

  void _initStates() {
    _statesController = WidgetStatesController({
      if (widget.isInitial) .selected,
      if (_isDisabled) .disabled,
    });
  }

  void _updateStates() {
    _statesController.update(.selected, widget.isInitial);
    _statesController.update(.disabled, _isDisabled);
  }
}

mixin _ItemMixinMenuLink<T extends Enum> on State<_Item<T>> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  SelectItemsController<T>? _selectItemsController;

  SelectItem<T>? get _selectItems => widget.item.selectItems;
  bool get _hasSelect => _selectItems != null && _selectItems!.items.isNotEmpty;
  bool get _hasSubTitle => !_hasSelect && widget.item.subTitle != null;
  double get _widthMenu => widget.width * .6;

  void _initSelectItems() {
    _selectItemsController = SelectItemsController<T>(
      _selectItems!.initial,
      selectItems: _selectItems!,
      onTap: hide,
    );
  }

  void _initAnimation(TickerProvider vsync) {
    _animationController = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: vsync,
    );
  }

  void show() async {
    await hide();
    _animationController!.forward();
    _overlayEntry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: _widthMenu,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(-widget.style.contentEdgePadding.left, 4.0),
          targetAnchor: .bottomRight,
          followerAnchor: .topRight,
          child: FadeTransition(
            opacity: _animationController!,
            child: GroupedList(
              items: _selectItemsController!.createItems(),
              divider: .full(),
            ),
          ),
        ),
      ),
    );
    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  Future<void> hide() async {
    if (_overlayEntry == null) return;
    await _animationController?.reverse();
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
