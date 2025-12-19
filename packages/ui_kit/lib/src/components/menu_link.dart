import 'package:ui_kit/ui.dart';

class MenuLink extends StatefulWidget {
  const MenuLink({
    super.key,
    required this.child,
    required this.actions,
    this.color,
  });

  final Widget child;
  final Map<String, VoidCallback> actions;
  final Color? color;

  @override
  State<MenuLink> createState() => _MenuLinkState();
}

class _MenuLinkState = State<MenuLink>
    with _MenuLinkApiMixin, _MessageMenuBuilderMixin, _MessageMenuOverlayMixin;

mixin _MenuLinkApiMixin on State<MenuLink> {
  void show() {}

  void hide() {}
}

mixin _MessageMenuBuilderMixin on _MenuLinkApiMixin {
  @override
  Widget build(BuildContext context) => InkWell(
    child: widget.child,
    onTap: () => widget.actions.isEmpty ? null : show(),
  );
}

class _MessageMenuLayout extends StatelessWidget {
  const _MessageMenuLayout({
    required this.actions,
    required this.hide,
    required this.color,
  });

  final Map<String, VoidCallback> actions;
  final VoidCallback hide;
  final Color? color;

  @override
  Widget build(BuildContext context) => Card(
    color: color,
    margin: .zero,
    child: Column(
      mainAxisSize: .max,
      crossAxisAlignment: .stretch,
      children: [
        for (final action in actions.entries)
          InkWell(
            borderRadius: const .all(.circular(8)),
            child: Padding(
              padding: const .all(16.0),
              child: UiText.bodyLarge(action.key),
            ),
            onTap: () {
              action.value();
              hide();
            },
          ),
      ],
    ),
  );
}

mixin _MessageMenuOverlayMixin on _MenuLinkApiMixin {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  @override
  void show() {
    super.show();
    hide();
    Overlay.of(context).insert(
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          width: 176,
          child: CompositedTransformFollower(
            link: _layerLink,
            followerAnchor: .topRight,
            showWhenUnlinked: false,
            child: _MessageMenuLayout(
              actions: widget.actions,
              hide: hide,
              color: widget.color,
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
