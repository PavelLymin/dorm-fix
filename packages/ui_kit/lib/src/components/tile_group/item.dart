import '../../../ui.dart';
import 'tile_group_style.dart';

class Item extends StatefulWidget {
  const Item({
    super.key,
    required this.item,
    this.isInitial = false,
    this.isFirst = false,
    this.isLast = false,
    required this.constraints,
  });

  final TileGroupItem item;
  final bool isInitial;
  final bool isFirst;
  final bool isLast;
  final BoxConstraints constraints;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item>
    with SingleTickerProviderStateMixin, _ItemStateMixin, _ItemMenuLinkMixin {
  late TileGroupStyle _style;
  @override
  void initState() {
    super.initState();
    _initStates();
    if (_hasSelect) {
      _controller = ValueNotifier(widget.item.initial);
      _initAnimation(this);
    }
  }

  @override
  void dispose() {
    hide();
    _controller?.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _style = .defaultStyle(context, widget.isFirst, widget.isLast);
  }

  @override
  void didUpdateWidget(covariant Item oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateStates();
    if (widget.item.initial != oldWidget.item.initial) {
      _controller?.value = widget.item.initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: _statesController,
      onPressed: onTap(_style),
      style: _style.buttonStyle,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: _ItemContent(
          item: widget.item,
          hasSelect: _hasSelect,
          isInitial: widget.isInitial,
          style: _style,
          controller: _controller,
        ),
      ),
    );
  }
}

class _ItemContent extends StatelessWidget {
  const _ItemContent({
    required this.item,
    required this.hasSelect,
    required this.isInitial,
    required this.style,
    this.controller,
  });

  final TileGroupItem item;
  final bool hasSelect;
  final bool isInitial;
  final TileGroupStyle style;
  final ValueNotifier<int?>? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      mainAxisSize: .max,
      children: [
        if (item.prefixIcon != null) ...[
          Icon(item.prefixIcon!.icon),
          const SizedBox(width: 12.0),
        ],
        Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            UiText2.m(item.title, overflow: .ellipsis, style: style.titleStyle),
            if (item.subTitle != null && !hasSelect)
              UiText2.s(
                item.subTitle!,
                overflow: .ellipsis,
                color: theme.colorPalette2.foregroundSecondary,
                style: style.subtitleStyle,
              ),
            if (hasSelect)
              ValueListenableBuilder(
                valueListenable: controller!,
                builder: (_, value, child) {
                  if (value == null) return child!;
                  return UiText2.s(
                    item.selectItem!.items[value]!,
                    overflow: .ellipsis,
                    color: theme.colorPalette2.foregroundSecondary,
                    style: style.subtitleStyle,
                  );
                },
                child: const SizedBox.shrink(),
              ),
          ],
        ),
        if (item.sufixIcon != null) ...[const Spacer(), item.sufixIcon!],
      ],
    );
  }
}

mixin _ItemStateMixin on State<Item> {
  late final WidgetStatesController _statesController;
  bool get _isDisabled => widget.item.onTap == null;

  void _initStates() => _statesController = WidgetStatesController({
    if (widget.isInitial) .selected,
    if (_isDisabled) .disabled,
  });

  void _updateStates() {
    _statesController.update(.selected, widget.isInitial);
    _statesController.update(.disabled, _isDisabled);
  }
}

mixin _ItemMenuLinkMixin on State<Item> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  ValueNotifier<int?>? _controller;
  AnimationController? _animationController;

  double get _widthMenu => widget.constraints.maxWidth * .6;
  TileSelectItem? get _selectItem => widget.item.selectItem;
  bool get _hasSelect => widget.item.selectItem != null;
  Map<int, String>? get _items => widget.item.selectItem?.items;

  void _initAnimation(TickerProvider vsync) =>
      _animationController = AnimationController(
        value: .0,
        duration: const Duration(milliseconds: 150),
        reverseDuration: const Duration(milliseconds: 100),
        vsync: vsync,
      );

  void show(TileGroupStyle style) async {
    await hide();
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        width: _widthMenu,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(style.padding!.left, style.padding!.bottom),
          targetAnchor: .bottomRight,
          followerAnchor: .topRight,
          child: FadeTransition(
            opacity: _animationController!,
            child: TileGroup(items: _toItems()),
          ),
        ),
      ),
    );
    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
      _animationController!.forward();
    }
  }

  List<TileGroupItem> _toItems() => _items!.entries
      .map(
        (e) => TileGroupItem(
          title: e.value,
          initial: _controller!.value,
          onTap: () async {
            _controller!.value = e.key;
            _selectItem?.onSelect(e.key);
            await hide();
          },
        ),
      )
      .toList();

  Future<void> hide() async {
    if (_overlayEntry == null) return;
    await _animationController?.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void Function()? onTap(TileGroupStyle style) {
    return _hasSelect ? () => show(style) : widget.item.onTap;
  }
}
