import 'package:ui_kit/ui.dart';
import 'line_calendar_layout.dart';

part 'line_calendar_controller.dart';

class LineCalendar extends StatelessWidget {
  const LineCalendar({
    super.key,
    required this.start,
    required this.end,
    this.today,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.controller,
    this.cacheExtent = 100,
    this.style = const LineCalendarStyle(),
  });

  final DateTime start;
  final DateTime end;
  final DateTime? today;
  final ScrollPhysics? physics;
  final LineCalendarController controller;
  final double cacheExtent;
  final LineCalendarStyle style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return LineCalendarLayout(
          style: context.appStyle.lineCalendarStyle,
          controller: controller,
          alignment: .center,
          physics: physics,
          cacheExtent: cacheExtent,
          start: start,
          end: end,
          initialScroll: today,
          today: today ?? .now(),
          constraints: constraints,
        );
      },
    );
  }
}

class LineCalendarStyle {
  const LineCalendarStyle({
    this.padding = AppPadding.horizontal,
    this.contentEdgeSpacing = 16,
    this.contentSpacing = 8,
  });

  final EdgeInsetsGeometry padding;
  final double contentEdgeSpacing;
  final double contentSpacing;

  AppWidgetStateMap<BoxDecoration> decoration(BuildContext context) {
    final colorPalette = context.palette;
    final style = context.appStyle.style;
    Border border = .all(color: colorPalette.border, width: style.borderWidth);
    return AppWidgetStateMap<BoxDecoration>({
      WidgetState.selected: BoxDecoration(
        color: colorPalette.primary,
        borderRadius: style.borderRadius,
      ),
      WidgetState.disabled: BoxDecoration(
        color: colorPalette.muted,
        border: border,
        borderRadius: style.borderRadius,
      ),
      WidgetState.any: BoxDecoration(
        color: colorPalette.secondary,
        border: border,
        borderRadius: style.borderRadius,
      ),
    });
  }

  AppWidgetStateMap<TextStyle> dateTextStyle(BuildContext context) {
    final colorPalette = context.palette;
    final typography = context.typography;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.titleLarge.copyWith(
        color: colorPalette.foreground,
        fontWeight: .w500,
      ),
      WidgetState.disabled: typography.titleLarge.copyWith(
        color: colorPalette.mutedForeground,
        fontWeight: .w500,
      ),
      WidgetState.any: typography.titleLarge.copyWith(
        color: colorPalette.primary,
        fontWeight: .w500,
      ),
    });
  }

  AppWidgetStateMap<TextStyle> weekdayTextStyle(BuildContext context) {
    final colorPalette = context.palette;
    final typography = context.typography;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.titleLarge.copyWith(
        color: colorPalette.foreground,
        fontWeight: .w500,
      ),
      WidgetState.disabled: typography.titleLarge.copyWith(
        color: colorPalette.mutedForeground,
        fontWeight: .w500,
      ),
      WidgetState.any: typography.titleLarge.copyWith(
        color: colorPalette.primary,
        fontWeight: .w500,
      ),
    });
  }
}
