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
    this.padding = AppPadding.horizontal,
    this.contentEdgeSpacing = 16,
    this.contentSpacing = 8,
  });

  final EdgeInsetsGeometry padding;
  final double contentEdgeSpacing;
  final double contentSpacing;

  AppWidgetStateMap<BoxDecoration> decoration(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return AppWidgetStateMap<BoxDecoration>({
      WidgetState.selected: BoxDecoration(
        color: palette.secondary,
        borderRadius: style.borderRadius,
        border: .all(color: palette.borderStrong, width: style.borderWidth),
      ),
      WidgetState.disabled: BoxDecoration(
        color: palette.muted,
        border: .all(color: palette.border, width: style.borderWidth),
        borderRadius: style.borderRadius,
      ),
      WidgetState.any: BoxDecoration(
        color: palette.card,
        border: .all(color: palette.border, width: style.borderWidth),
        borderRadius: style.borderRadius,
      ),
    });
  }

  AppWidgetStateMap<TextStyle> dateTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.titleLarge.copyWith(
        color: palette.foreground,
        fontWeight: .w500,
      ),
      WidgetState.disabled: typography.titleLarge.copyWith(
        color: palette.mutedForeground,
        fontWeight: .w500,
      ),
      WidgetState.any: typography.titleLarge.copyWith(
        color: palette.foreground,
        fontWeight: .w500,
      ),
    });
  }

  AppWidgetStateMap<TextStyle> weekdayTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final typography = theme.appTypography;
    return AppWidgetStateMap<TextStyle>({
      WidgetState.selected: typography.titleMedium.copyWith(
        color: palette.foreground,
        fontWeight: .w500,
      ),
      WidgetState.disabled: typography.titleMedium.copyWith(
        color: palette.mutedForeground,
        fontWeight: .w500,
      ),
      WidgetState.any: typography.titleMedium.copyWith(
        color: palette.foreground,
        fontWeight: .w500,
      ),
    });
  }
}
