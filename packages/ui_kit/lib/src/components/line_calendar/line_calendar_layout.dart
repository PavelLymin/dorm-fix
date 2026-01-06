import 'package:flutter/rendering.dart';
import 'package:ui_kit/src/components/line_calendar/line_calendar_controller.dart';
import 'package:ui_kit/ui.dart';

class DefaultData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

extension RenderBoxes on RenderBox {
  BoxParentData get data => parentData! as BoxParentData;
}

class LineCalendarLayout extends StatefulWidget {
  const LineCalendarLayout({
    super.key,
    required this.style,
    required this.alignment,
    required this.physics,
    required this.cacheExtent,
    required this.start,
    required this.end,
    required this.initialScroll,
    required this.today,
    required this.constraints,
    required this.selectedDate,
  });

  final LineCalendarStyle style;
  final AlignmentDirectional alignment;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final DateTime start;
  final DateTime? end;
  final DateTime? initialScroll;
  final DateTime today;
  final BoxConstraints constraints;
  final ValueNotifier<DateTime?> selectedDate;

  @override
  State<LineCalendarLayout> createState() => _LineCalendarLayoutState();
}

class _LineCalendarLayoutState extends State<LineCalendarLayout> {
  late ScrollController _scrollController;
  late double _width;

  @override
  void initState() {
    super.initState();

    _width = _estimateWidth();

    final start =
        ((widget.initialScroll ?? widget.today)
            .difference(widget.start)
            .inDays) *
        _width;
    _scrollController = ScrollController(
      initialScrollOffset: switch (widget.alignment.start) {
        -1 => start,
        1 => start - widget.constraints.maxWidth + _width,
        _ => start - (widget.constraints.maxWidth - _width) / 2,
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _estimateWidth() {
    double height(LineCalendarStyle style, Set<WidgetState> states) {
      final dateHeight = style.dateTextStyle.resolve(states).fontSize ?? 0;
      final weekdayHeight =
          style.weekdayTextStyle.resolve(states).fontSize ?? 0;
      final otherHeight =
          widget.style.contentSpacing + (widget.style.contentEdgeSpacing * 2);

      return dateHeight + weekdayHeight + otherHeight;
    }

    return [
      height(widget.style, const {.selected}),
      height(widget.style, const {.selected, .hovered}),
      height(widget.style, const {.hovered}),
      height(widget.style, const {}),
    ].reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget.today;

    return SpeculativeLayout(
      children: [
        ItemContent(
          style: widget.style,
          states: const {.selected},
          date: placeholder,
        ),
        ItemContent(
          style: widget.style,
          states: const {.selected, .hovered},
          date: placeholder,
        ),
        ItemContent(style: widget.style, states: const {}, date: placeholder),
        ItemContent(
          style: widget.style,
          states: const {.hovered},
          date: placeholder,
        ),
        ListView.builder(
          controller: _scrollController,
          scrollDirection: .horizontal,
          padding: .zero,
          physics: widget.physics,
          cacheExtent: widget.cacheExtent,
          itemExtent: _width,
          itemCount: widget.end == null
              ? null
              : widget.end!.difference(widget.start).inDays + 1,
          itemBuilder: (_, index) {
            final date = widget.start.add(Duration(days: index));
            return Padding(
              padding: widget.style.padding,
              child: Item(
                date: date.truncateAndStripTimezone(),
                style: widget.style,
                selectedDate: widget.selectedDate,
              ),
            );
          },
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.date,
    required this.style,
    required this.selectedDate,
  });

  final DateTime date;
  final LineCalendarStyle style;
  final ValueNotifier<DateTime?> selectedDate;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedDate,
      builder: (context, state, child) {
        return ClickableCard(
          isSelected: date == state,
          onPress: () {
            selectedDate.value = date;
          },
          builder: (context, state, _) => DecoratedBox(
            decoration: style.decoration.resolve(state),
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              spacing: 16,
              children: [
                Text(
                  date.day.toString(),
                  style: style.dateTextStyle.resolve(state),
                ),
                Text(
                  date.weekday.toString(),
                  style: style.weekdayTextStyle.resolve(state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SpeculativeLayout extends MultiChildRenderObjectWidget {
  const SpeculativeLayout({required super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext _) => _SpeculativeBox();
}

class _SpeculativeBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, DefaultData>,
        RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  @override
  void setupParentData(RenderObject child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    final selected = firstChild!;
    final selectedHovered = childAfter(selected)!;
    final unselected = childAfter(selectedHovered)!;
    final unselectedHovered = childAfter(unselected)!;

    final maxHeight = [
      selected.getDryLayout(constraints).height,
      selectedHovered.getDryLayout(constraints).height,
      unselected.getDryLayout(constraints).height,
      unselectedHovered.getDryLayout(constraints).height,
    ].reduce((a, b) => a > b ? a : b);

    final heightConstraints = constraints.copyWith(maxHeight: maxHeight);
    final viewport = childAfter(unselectedHovered)!
      ..layout(heightConstraints, parentUsesSize: true);
    size = constraints.constrain(viewport.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) =>
      context.paintChild(lastChild!, offset);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final viewport = lastChild!;
    return result.addWithPaintOffset(
      offset: viewport.data.offset,
      position: position,
      hitTest: (result, transformed) =>
          viewport.hitTest(result, position: transformed),
    );
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) =>
      visitor(lastChild!);
}

class ItemContent extends StatelessWidget {
  final LineCalendarStyle style;
  final DateTime date;
  final Set<WidgetState> states;

  const ItemContent({
    required this.style,
    required this.date,
    required this.states,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: style.decoration.resolve(states),
      child: Padding(
        padding: .symmetric(vertical: style.contentEdgeSpacing),
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: style.contentSpacing,
          children: [
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.dateTextStyle.resolve(states),
              child: Text(date.day.toString()),
            ),
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.weekdayTextStyle.resolve(states),
              child: Text(date.weekday.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
