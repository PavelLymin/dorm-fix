import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:ui_kit/ui.dart';

class ItemPosition {
  const ItemPosition({
    required this.index,
    required this.leadingEdge,
    required this.trailingEdge,
  });

  final int index;
  final double leadingEdge;
  final double trailingEdge;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemPosition &&
          runtimeType == other.runtimeType &&
          other.index == index &&
          other.leadingEdge == leadingEdge &&
          other.trailingEdge == trailingEdge;

  @override
  int get hashCode => Object.hash(index, leadingEdge, trailingEdge);

  @override
  String toString() =>
      'ItemPosition('
      'index: $index, '
      'leadingEdge: $leadingEdge, '
      'trailingEdge: $trailingEdge)';
}

class ChatList extends StatefulWidget {
  const ChatList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.controller,
    this.itemPositionsNotifier,
    this.alignment = 0,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollController controller;
  final ValueNotifier<Iterable<ItemPosition>>? itemPositionsNotifier;
  final double alignment;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with _ChatListStateMixin {
  @override
  Widget build(BuildContext context) {
    return RegistryScope(
      elementNotifier: _registerElements,
      child: CustomScrollView(
        reverse: true,
        controller: widget.controller,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.itemCount,
              addSemanticIndexes: false,
              (context, index) => RegisteredElementWidget(
                key: ValueKey(index),
                child: widget.itemBuilder(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

mixin _ChatListStateMixin on State<ChatList> {
  final _registerElements = ValueNotifier<Set<Element>?>(null);
  void Function()? _updateScheduled;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_schedulePositionNotificationUpdate);
    _schedulePositionNotificationUpdate();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_schedulePositionNotificationUpdate);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _schedulePositionNotificationUpdate();
  }

  void _schedulePositionNotificationUpdate() {
    if (_updateScheduled == null) {
      _updateScheduled = _updateItemPosition;
      SchedulerBinding.instance.addPersistentFrameCallback(
        (_) => _updateScheduled?.call(),
      );
    }
  }

  void _scroll(
    RenderViewportBase viewport,
    RenderBox box,
    List<ItemPosition> positions,
    ValueKey<int> key,
  ) {
    final reveal = viewport.getOffsetToReveal(box, 0).offset;
    if (!reveal.isFinite) return;

    final itemOffset =
        reveal -
        viewport.offset.pixels +
        widget.alignment * viewport.size.height;

    double leadingEdge =
        itemOffset.round() / widget.controller.position.viewportDimension;
    double trailingEdge =
        (itemOffset + box.size.height).round() /
        widget.controller.position.viewportDimension;
    positions.add(
      ItemPosition(
        index: key.value,
        leadingEdge: leadingEdge,
        trailingEdge: trailingEdge,
      ),
    );
  }

  void _updateItemPosition() {
    if (!mounted) return;

    final elements = _registerElements.value;
    if (elements == null) {
      _updateScheduled = null;
      return;
    }

    final List<ItemPosition> positions = [];
    RenderViewportBase? viewport;
    for (final element in elements) {
      final RenderBox? box = element.renderObject as RenderBox?;
      viewport ??= RenderAbstractViewport.of(box) as RenderViewportBase?;

      final ValueKey<int> key = element.widget.key! as ValueKey<int>;
      if (box case RenderBox(:final hasSize) when !hasSize) continue;

      _scroll(viewport!, box!, positions, key);
    }

    widget.itemPositionsNotifier?.value = positions;
    _updateScheduled = null;
  }
}

class RegistryScope extends StatefulWidget {
  const RegistryScope({super.key, required this.child, this.elementNotifier});

  final Widget child;
  final ValueNotifier<Set<Element>?>? elementNotifier;

  @override
  State<RegistryScope> createState() => _RegistryScopeState();
}

class _RegistryScopeState extends State<RegistryScope> {
  final Set<Element> _registeredElements = {};

  @override
  Widget build(BuildContext context) =>
      _InheritedRegistryWidget(state: this, child: widget.child);
}

class _InheritedRegistryWidget extends InheritedWidget {
  const _InheritedRegistryWidget({required this.state, required super.child});

  final _RegistryScopeState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class RegisteredElementWidget extends SingleChildRenderObjectWidget {
  const RegisteredElementWidget({required super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => RenderProxyBox();

  @override
  SingleChildRenderObjectElement createElement() => _RegisteredElement(this);
}

class _RegisteredElement extends SingleChildRenderObjectElement {
  _RegisteredElement(super.widget);

  _RegistryScopeState? _registryWidgetState;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>();
    if (inheritedRegistryWidget == null) return;

    _registryWidgetState = inheritedRegistryWidget.state;
    _registryWidgetState?._registeredElements.add(this);
    _registryWidgetState?.widget.elementNotifier?.value =
        _registryWidgetState?._registeredElements;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>();
    if (inheritedRegistryWidget == null) return;
    _registryWidgetState = inheritedRegistryWidget.state;
    _registryWidgetState?._registeredElements.add(this);
    _registryWidgetState?.widget.elementNotifier?.value =
        _registryWidgetState?._registeredElements;
  }

  @override
  void unmount() {
    _registryWidgetState?._registeredElements.remove(this);
    _registryWidgetState?.widget.elementNotifier?.value =
        _registryWidgetState?._registeredElements;
    super.unmount();
  }
}
