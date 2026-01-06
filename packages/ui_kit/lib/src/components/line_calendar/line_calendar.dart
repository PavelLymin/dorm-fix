import 'package:ui_kit/ui.dart';

import 'line_calendar_controller.dart';
import 'line_calendar_layout.dart';

class LineCalendar extends StatelessWidget {
  const LineCalendar({
    super.key,
    required this.start,
    required this.end,
    this.today,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.controller,
    required this.style,
    this.cacheExtent = 100,
  });

  final DateTime start;
  final DateTime end;
  final DateTime? today;
  final ScrollPhysics? physics;
  final LineCalendarController controller;
  final LineCalendarStyle style;
  final double cacheExtent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return LineCalendarLayout(
          style: style,
          selectedDate: controller,
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
    required this.todayIndicatorColor,
    required this.dateTextStyle,
    required this.weekdayTextStyle,
  });

  final EdgeInsetsGeometry padding;
  final double contentEdgeSpacing;
  final double contentSpacing;
  final AppWidgetStateMap<BoxDecoration> decoration;
  final AppWidgetStateMap<Color> todayIndicatorColor;
  final AppWidgetStateMap<TextStyle> dateTextStyle;
  final AppWidgetStateMap<TextStyle> weekdayTextStyle;

  factory LineCalendarStyle.defaultStyle(
    ColorPalette colorPalette,
    AppTypography typography,
    AppStyle style,
  ) {
    final focusedBorder = Border.all(
      color: colorPalette.border,
      width: style.borderWidth,
    );
    final regularBorder = Border.all(
      color: colorPalette.border,
      width: style.borderWidth,
    );

    return .new(
      decoration: AppWidgetStateMap<BoxDecoration>({
        WidgetState.disabled &
            WidgetState.selected &
            WidgetState.focused: BoxDecoration(
          color: colorPalette.muted.withValues(alpha: .3),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled & WidgetState.selected: BoxDecoration(
          color: colorPalette.muted.withValues(alpha: .3),
          border: regularBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled: BoxDecoration(
          color: colorPalette.muted,
          border: regularBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected &
            (WidgetState.hovered | WidgetState.pressed): BoxDecoration(
          color: colorPalette.primary.withValues(alpha: .8),
          borderRadius: style.borderRadius,
        ),
        WidgetState.selected: BoxDecoration(
          color: colorPalette.primary,
          borderRadius: style.borderRadius,
        ),
        (WidgetState.hovered | WidgetState.pressed): BoxDecoration(
          color: colorPalette.secondary.withValues(alpha: .2),
          border: regularBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: BoxDecoration(
          color: colorPalette.secondary.withValues(alpha: .2),
          border: focusedBorder,
          borderRadius: style.borderRadius,
        ),
        WidgetState.any: BoxDecoration(
          color: colorPalette.secondary,
          border: regularBorder,
          borderRadius: style.borderRadius,
        ),
      }),
      todayIndicatorColor: AppWidgetStateMap<Color>({
        WidgetState.disabled & WidgetState.selected: colorPalette
            .mutedForeground
            .withValues(alpha: .5),
        WidgetState.disabled: colorPalette.mutedForeground.withValues(
          alpha: .5,
        ),
        WidgetState.selected & (WidgetState.hovered | WidgetState.pressed):
            colorPalette.primaryForeground,
        WidgetState.selected: colorPalette.primaryForeground,
        (WidgetState.hovered | WidgetState.pressed): colorPalette.primary
            .withValues(alpha: .8),
        WidgetState.any: colorPalette.primary,
      }),
      dateTextStyle: AppWidgetStateMap<TextStyle>({
        WidgetState.disabled & WidgetState.selected: typography.titleLarge
            .copyWith(
              color: colorPalette.mutedForeground.withValues(alpha: .5),
              fontWeight: .w500,
            ),
        WidgetState.disabled: typography.titleLarge.copyWith(
          color: colorPalette.mutedForeground.withValues(alpha: .5),
          fontWeight: .w500,
        ),
        WidgetState.selected: typography.titleLarge.copyWith(
          color: colorPalette.primaryForeground,
          fontWeight: .w500,
        ),
        WidgetState.any: typography.titleLarge.copyWith(
          color: colorPalette.primary,
          fontWeight: .w500,
        ),
      }),
      weekdayTextStyle: AppWidgetStateMap<TextStyle>({
        WidgetState.disabled & WidgetState.selected: typography.titleMedium
            .copyWith(
              color: colorPalette.mutedForeground.withValues(alpha: .5),
              fontWeight: .w500,
            ),
        WidgetState.disabled: typography.titleMedium.copyWith(
          color: colorPalette.mutedForeground.withValues(alpha: .5),
          fontWeight: .w500,
        ),
        WidgetState.selected: typography.titleMedium.copyWith(
          color: colorPalette.primaryForeground,
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
