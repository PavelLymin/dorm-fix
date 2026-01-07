import 'package:ui_kit/src/theme/style_data.dart';
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
  });

  final DateTime start;
  final DateTime end;
  final DateTime? today;
  final ScrollPhysics? physics;
  final LineCalendarController controller;
  final double cacheExtent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return LineCalendarLayout(
          style: context.styles.lineCalendarStyle,
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
    required this.decoration,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
  });

  final EdgeInsetsGeometry padding;
  final double contentEdgeSpacing;
  final double contentSpacing;
  final AppWidgetStateMap<BoxDecoration> decoration;
  final AppWidgetStateMap<TextStyle> dateTextStyle;
  final AppWidgetStateMap<TextStyle> weekdayTextStyle;

  factory LineCalendarStyle.defaultStyle(BuildContext context, AppStyle style) {
    final colorPalette = Theme.of(context).colorPalette;
    final typography = Theme.of(context).appTypography;

    final border = Border.all(
      color: colorPalette.border,
      width: style.borderWidth,
    );

    return .new(
      decoration: AppWidgetStateMap<BoxDecoration>({
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
      }),
      dateTextStyle: AppWidgetStateMap<TextStyle>({
        WidgetState.selected: typography.titleLarge.copyWith(
          color: colorPalette.primaryForeground,
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
      }),
      weekdayTextStyle: AppWidgetStateMap<TextStyle>({
        WidgetState.selected: typography.titleMedium.copyWith(
          color: colorPalette.primaryForeground,
          fontWeight: .w500,
        ),
        WidgetState.disabled: typography.titleMedium.copyWith(
          color: colorPalette.mutedForeground,
          fontWeight: .w500,
        ),
        WidgetState.any: typography.titleMedium.copyWith(
          color: colorPalette.mutedForeground,
          fontWeight: .w500,
        ),
      }),
    );
  }
}
