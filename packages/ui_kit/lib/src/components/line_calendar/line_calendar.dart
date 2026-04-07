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
          style: style,
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
    this.padding = const .symmetric(horizontal: 6.0),
    this.contentEdgeSpacing = 16.0,
    this.contentSpacing = 8.0,
  });

  final EdgeInsetsGeometry padding;
  final double contentEdgeSpacing;
  final double contentSpacing;

  AppWidgetStateMap<BoxDecoration> decoration(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return AppWidgetStateMap<BoxDecoration>({
      WidgetState.selected: BoxDecoration(color: palette.primary),
      WidgetState.disabled: BoxDecoration(color: palette.disabled),
      WidgetState.any: BoxDecoration(color: palette.card),
    });
  }

  AppWidgetStateMap<TextStyle> dateTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.lBold.copyWith(
        color: palette.foreground,
      ),
      WidgetState.disabled: typography.lBold.copyWith(
        color: palette.foregroundDisabled,
      ),
      WidgetState.any: typography.lBold.copyWith(color: palette.foreground),
    });
  }

  AppWidgetStateMap<TextStyle> weekdayTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.m.copyWith(color: palette.foreground),
      WidgetState.disabled: typography.m.copyWith(
        color: palette.foregroundDisabled,
      ),
      WidgetState.any: typography.m.copyWith(color: palette.foreground),
    });
  }
}
