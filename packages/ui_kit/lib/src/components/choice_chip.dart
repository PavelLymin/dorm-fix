import 'package:ui_kit/ui.dart';

class ChipItem<T extends Object> {
  const ChipItem({required this.value, required this.title, this.icon});

  final T value;
  final String title;
  final Icon? icon;
}

class UiChoiceChip<T extends Object> extends StatefulWidget {
  const UiChoiceChip({
    super.key,
    required this.options,
    required this.initial,
    required this.onChange,
    this.style = const ChoiceChipStyle(),
  });

  final List<ChipItem<T>> options;
  final T initial;
  final void Function(T) onChange;
  final ChoiceChipStyle style;

  @override
  State<UiChoiceChip<T>> createState() => _UiChoiceChipState<T>();
}

class _UiChoiceChipState<T extends Object> extends State<UiChoiceChip<T>> {
  late List<GlobalKey> _keys;
  late int _initial;
  double _indicatorLeft = 0.0;
  double _indicatorWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _initialIndex();
    _initKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _keys.clear();
  }

  @override
  void didUpdateWidget(covariant UiChoiceChip<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options != oldWidget.options) _initKeys();
    if (widget.initial != oldWidget.initial) _initialIndex();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  void _initKeys() =>
      _keys = .generate(widget.options.length, (index) => GlobalKey());

  void _updateIndicator() {
    if (!mounted || _keys.isEmpty) return;

    int index = _initialIndex();
    if (index == -1) return;

    double left = 0.0;
    for (int i = 0; i < index; i++) {
      final context = _keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        left += box?.size.width ?? 0.0;
      }
    }

    double width = 0.0;
    final selectedContext = _keys[index].currentContext;
    if (selectedContext != null) {
      final box = selectedContext.findRenderObject() as RenderBox?;
      width = box?.size.width ?? 0.0;
    }

    if (_indicatorLeft != left || _indicatorWidth != width) {
      setState(() {
        _indicatorLeft = left;
        _indicatorWidth = width;
      });
    }
  }

  int _initialIndex() => _initial = widget.options.indexWhere(
    (item) => item.value == widget.initial,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final style = theme.appStyle;
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.style.barColor ?? palette.background,
          borderRadius: widget.style.borderRadius ?? style.borderRadius,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: widget.style.duration,
              curve: widget.style.curve,
              left: _indicatorLeft,
              top: 0,
              bottom: 0,
              width: _indicatorWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.style.indicatorColor ?? palette.primary,
                  borderRadius: widget.style.borderRadius ?? style.borderRadius,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: List.generate(
                widget.options.length,
                (index) => _ButtonItemOption<T>(
                  key: _keys[index],
                  item: widget.options[index],
                  onChange: widget.onChange,
                  indicator: index == _initial,
                  style: widget.style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceChipStyle {
  const ChoiceChipStyle({
    this.barColor,
    this.indicatorColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.indicatorTextStyle,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final Color? barColor;
  final Color? indicatorColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? indicatorTextStyle;
  final Duration duration;
  final Curve curve;
}

class _ButtonItemOption<T extends Object> extends StatelessWidget {
  const _ButtonItemOption({
    super.key,
    required this.item,
    required this.onChange,
    required this.indicator,
    required this.style,
  });

  final ChipItem<T> item;
  final void Function(T) onChange;
  final bool indicator;
  final ChoiceChipStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => onChange(item.value),
      child: Padding(
        padding: AppInsets.card,
        child: Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            if (item.icon != null) item.icon!,
            if (item.icon != null) const SizedBox(width: 8.0),
            UiText2.m(
              item.title,
              overflow: .ellipsis,
              style: indicator ? style.indicatorTextStyle : style.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

// class ChipItem<T extends Object> {
//   const ChipItem({required this.value, required this.title, this.icon});

//   final T value;
//   final String title;
//   final Icon? icon;
// }

// class UiChoiceChip<T extends Object> extends StatefulWidget {
//   const UiChoiceChip({
//     super.key,
//     required this.options,
//     required this.initial,
//     required this.onChange,
//     this.style = const ChoiceChipStyle(),
//   });

//   final List<ChipItem<T>> options;
//   final T initial;
//   final void Function(T) onChange;
//   final ChoiceChipStyle style;

//   @override
//   State<UiChoiceChip<T>> createState() => _UiChoiceChipState<T>();
// }

// class _UiChoiceChipState<T extends Object> extends State<UiChoiceChip<T>> {
//   late List<GlobalKey> _keys;
//   late int _initial;
//   double _indicatorLeft = 0.0;
//   double _indicatorWidth = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _initialIndex();
//     _initKeys();
//     // WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _keys.clear();
//   }

//   @override
//   void didUpdateWidget(covariant UiChoiceChip<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.options != oldWidget.options) _initKeys();
//     if (widget.initial != oldWidget.initial) _initialIndex();
//     // WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
//   }

//   void _initKeys() =>
//       _keys = .generate(widget.options.length, (index) => GlobalKey());

//   // void _updateIndicator() {
//   //   if (!mounted || _keys.isEmpty) return;

//   //   int index = _initialIndex();
//   //   if (index == -1) return;

//   //   double left = 0.0;
//   //   for (int i = 0; i < index; i++) {
//   //     final context = _keys[i].currentContext;
//   //     if (context != null) {
//   //       final box = context.findRenderObject() as RenderBox?;
//   //       left += box?.size.width ?? 0.0;
//   //     }
//   //   }

//   //   double width = 0.0;
//   //   final selectedContext = _keys[index].currentContext;
//   //   if (selectedContext != null) {
//   //     final box = selectedContext.findRenderObject() as RenderBox?;
//   //     width = box?.size.width ?? 0.0;
//   //   }

//   //   if (_indicatorLeft != left || _indicatorWidth != width) {
//   //     setState(() {
//   //       _indicatorLeft = left;
//   //       _indicatorWidth = width;
//   //     });
//   //   }
//   // }

//   int _initialIndex() => _initial = widget.options.indexWhere(
//     (item) => item.value == widget.initial,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final palette = theme.colorPalette2;
//     final style = theme.appStyle;
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: widget.style.barColor ?? palette.background,
//         borderRadius: widget.style.borderRadius ?? style.borderRadius,
//       ),
//       child: LayoutBuilder(
//         builder: (_, constraints) {
//           final itemWidth = constraints.maxWidth / widget.options.length;
//           return Stack(
//             alignment: .center,
//             children: [
//               AnimatedPositioned(
//                 duration: widget.style.duration,
//                 curve: widget.style.curve,
//                 left: itemWidth * _initial,
//                 top: 0,
//                 bottom: 0,
//                 width: itemWidth,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: widget.style.indicatorColor ?? palette.primary,
//                     borderRadius:
//                         widget.style.borderRadius ?? style.borderRadius,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: .center,
//                 crossAxisAlignment: .center,
//                 mainAxisSize: .min,
//                 children: List.generate(
//                   widget.options.length,
//                   (index) => SizedBox(
//                     width: itemWidth,
//                     child: _ButtonItemOption<T>(
//                       key: _keys[index],
//                       item: widget.options[index],
//                       onChange: widget.onChange,
//                       indicator: index == _initial,
//                       style: widget.style,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class ChoiceChipStyle {
//   const ChoiceChipStyle({
//     this.barColor,
//     this.indicatorColor,
//     this.padding,
//     this.borderRadius,
//     this.textStyle,
//     this.indicatorTextStyle,
//     this.duration = const Duration(milliseconds: 300),
//     this.curve = Curves.easeInOut,
//   });

//   final Color? barColor;
//   final Color? indicatorColor;
//   final EdgeInsets? padding;
//   final BorderRadius? borderRadius;
//   final TextStyle? textStyle;
//   final TextStyle? indicatorTextStyle;
//   final Duration duration;
//   final Curve curve;
// }

// class _ButtonItemOption<T extends Object> extends StatelessWidget {
//   const _ButtonItemOption({
//     super.key,
//     required this.item,
//     required this.onChange,
//     required this.indicator,
//     required this.style,
//   });

//   final ChipItem<T> item;
//   final void Function(T) onChange;
//   final bool indicator;
//   final ChoiceChipStyle style;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: .opaque,
//       onTap: () => onChange(item.value),
//       child: Padding(
//         padding: AppInsets.card,
//         child: Row(
//           mainAxisAlignment: .center,
//           crossAxisAlignment: .center,
//           mainAxisSize: .min,
//           spacing: 8.0,
//           children: [
//             if (item.icon != null) item.icon!,
//             Flexible(
//               child: UiText2.m(
//                 item.title,
//                 overflow: .ellipsis,
//                 style: indicator ? style.indicatorTextStyle : style.textStyle,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
