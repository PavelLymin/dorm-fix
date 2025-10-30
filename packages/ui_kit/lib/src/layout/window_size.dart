import 'dart:ui';

import 'package:ui_kit/ui.dart';

sealed class WindowSize extends Size {
  WindowSize({
    required this.minWidth,
    required this.maxWidth,
    required Size size,
  }) : super.copy(size);

  final double minWidth;
  final double maxWidth;

  factory WindowSize.fromSize(Size size) {
    return switch (size.width) {
      >= WindowSizeCompact._minWidth && < WindowSizeMedium._minWidth =>
        WindowSizeCompact(size: size),
      >= WindowSizeMedium._minWidth && < WindowSizeExpanded._minWidth =>
        WindowSizeMedium(size: size),
      >= WindowSizeExpanded._minWidth && < WindowSizeLarge._minWidth =>
        WindowSizeExpanded(size: size),
      >= WindowSizeLarge._minWidth && < WindowSizeExtraLarge._minWidth =>
        WindowSizeLarge(size: size),
      >= WindowSizeExtraLarge._minWidth => WindowSizeExtraLarge(size: size),
      _ => throw AssertionError('Invalid window size: $size'),
    };
  }

  bool get isCompact => maybeMap(orElse: () => false, compact: (_) => true);

  bool get isCompactOrLarger => maybeMap(
    orElse: () => false,
    compact: (_) => true,
    medium: (_) => true,
    expanded: (_) => true,
    large: (_) => true,
    extraLarge: (_) => true,
  );

  bool get isMedium => maybeMap(orElse: () => false, medium: (_) => true);

  bool get isMediumOrLarger => maybeMap(
    orElse: () => false,
    medium: (_) => true,
    expanded: (_) => true,
    large: (_) => true,
    extraLarge: (_) => true,
  );

  bool get isExpanded => maybeMap(orElse: () => false, expanded: (_) => true);

  bool get isExpandedOrLarger => maybeMap(
    orElse: () => false,
    expanded: (_) => true,
    large: (_) => true,
    extraLarge: (_) => true,
  );

  bool get isLarge => maybeMap(orElse: () => false, large: (_) => true);

  bool get isLargeOrLarger => maybeMap(
    orElse: () => false,
    large: (_) => true,
    extraLarge: (_) => true,
  );

  bool get isExtraLarge =>
      maybeMap(orElse: () => false, extraLarge: (_) => true);

  T map<T>({
    required T Function(WindowSizeCompact) compact,
    required T Function(WindowSizeMedium) medium,
    required T Function(WindowSizeExpanded) expanded,
    required T Function(WindowSizeLarge) large,
    required T Function(WindowSizeExtraLarge) extraLarge,
  }) => switch (this) {
    final WindowSizeCompact size => compact(size),
    final WindowSizeMedium size => medium(size),
    final WindowSizeExpanded size => expanded(size),
    final WindowSizeLarge size => large(size),
    final WindowSizeExtraLarge size => extraLarge(size),
  };

  T maybeMap<T>({
    required T Function() orElse,
    T Function(WindowSizeCompact)? compact,
    T Function(WindowSizeMedium)? medium,
    T Function(WindowSizeExpanded)? expanded,
    T Function(WindowSizeLarge)? large,
    T Function(WindowSizeExtraLarge)? extraLarge,
  }) => switch (this) {
    final WindowSizeCompact size => compact?.call(size) ?? orElse(),
    final WindowSizeMedium size => medium?.call(size) ?? orElse(),
    final WindowSizeExpanded size => expanded?.call(size) ?? orElse(),
    final WindowSizeLarge size => large?.call(size) ?? orElse(),
    final WindowSizeExtraLarge size => extraLarge?.call(size) ?? orElse(),
  };
}

final class WindowSizeCompact extends WindowSize {
  WindowSizeCompact({
    required super.size,
    super.minWidth = _minWidth,
    super.maxWidth = _maxWidth,
  });

  static const _minWidth = 0.0;

  static const _maxWidth = 599.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeCompact &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, width, height]);

  @override
  String toString() => 'WindowSizeCompact';
}

final class WindowSizeMedium extends WindowSize {
  WindowSizeMedium({
    required super.size,
    super.minWidth = _minWidth,
    super.maxWidth = _maxWidth,
  });

  static const _minWidth = 600.0;

  static const _maxWidth = 839.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeMedium &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, width, height]);

  @override
  String toString() => 'WindowSizeMedium';
}

final class WindowSizeExpanded extends WindowSize {
  WindowSizeExpanded({
    required super.size,
    super.minWidth = _minWidth,
    super.maxWidth = _maxWidth,
  });

  static const _minWidth = 840.0;

  static const _maxWidth = 1199.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeExpanded &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, width, height]);

  @override
  String toString() => 'WindowSizeExpanded';
}

final class WindowSizeLarge extends WindowSize {
  WindowSizeLarge({
    required super.size,
    super.minWidth = _minWidth,
    super.maxWidth = _maxWidth,
  });

  static const _minWidth = 1200.0;

  static const _maxWidth = 1599.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeLarge &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, width, height]);

  @override
  String toString() => 'WindowSizeLarge';
}

final class WindowSizeExtraLarge extends WindowSize {
  WindowSizeExtraLarge({
    required super.size,
    super.minWidth = _minWidth,
    super.maxWidth = _maxWidth,
  });

  static const _minWidth = 1600.0;

  static const _maxWidth = double.infinity;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeExtraLarge &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, width, height]);

  @override
  String toString() => 'WindowSizeExtraLarge';
}

class WindowSizeScope extends StatefulWidget {
  const WindowSizeScope({required this.child, super.key});

  final Widget child;

  static WindowSize of(BuildContext context, {bool listen = true}) {
    final inheritedWindowSize = listen
        ? context.dependOnInheritedWidgetOfExactType<_InheritedWindowSize>()
        : context.getInheritedWidgetOfExactType<_InheritedWindowSize>();

    return inheritedWindowSize?.windowSize ??
        WindowSize.fromSize(MediaQuery.sizeOf(context));
  }

  @override
  State<WindowSizeScope> createState() => _WindowSizeScopeState();
}

class _WindowSizeScopeState extends State<WindowSizeScope>
    with WidgetsBindingObserver {
  late WindowSize _windowSize;

  WindowSize _getWindowSize() {
    final view = PlatformDispatcher.instance.views.first;
    return WindowSize.fromSize(view.physicalSize / view.devicePixelRatio);
  }

  @override
  void initState() {
    super.initState();

    _windowSize = _getWindowSize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final windowSize = _getWindowSize();

    if (_windowSize != windowSize) {
      setState(() => _windowSize = windowSize);
    }
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedWindowSize(windowSize: _windowSize, child: widget.child);
}

class _InheritedWindowSize extends InheritedWidget {
  const _InheritedWindowSize({required this.windowSize, required super.child});

  final WindowSize windowSize;

  @override
  bool updateShouldNotify(_InheritedWindowSize oldWidget) =>
      windowSize != oldWidget.windowSize;
}
