import 'package:ui_kit/ui.dart';

class MenuLink extends StatefulWidget {
  const MenuLink({super.key, required this.child, required this.items});

  final Widget child;
  final List<GroupedListItem> items;

  @override
  State<MenuLink> createState() => _MenuLinkState();
}

class _MenuLinkState = State<MenuLink>
    with _MenuLinkApiMixin, _MenuLinkBuilderMixin, _MenuLinkOverlayMixin;

mixin _MenuLinkApiMixin on State<MenuLink> {
  void show() {}

  void hide() {}
}

mixin _MenuLinkBuilderMixin on _MenuLinkApiMixin {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: widget.items.isEmpty ? null : show,
    child: widget.child,
  );
}

mixin _MenuLinkOverlayMixin on _MenuLinkApiMixin {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  @override
  void show() {
    super.show();
    hide();
    Overlay.of(context).insert(
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          width: 200.0,
          child: CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: .bottomLeft,
            followerAnchor: .topRight,
            showWhenUnlinked: false,
            child: GroupedList(
              style: .defaultStyle(context).copyWith(
                contentEdgePadding: .symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              items: widget.items,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hide() {
    super.hide();
    if (_overlayEntry == null) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      CompositedTransformTarget(link: _layerLink, child: super.build(context));
}
