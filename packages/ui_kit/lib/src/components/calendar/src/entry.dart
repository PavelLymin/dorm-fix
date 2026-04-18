import '../../../../ui.dart';

class Entry extends StatelessWidget {
  const Entry({
    super.key,
    required this.day,
    required this.thisMonth,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isDateInRange,
    required this.isToday,
    this.onTap,
  });

  final String day;
  final bool thisMonth;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isDateInRange;
  final bool isToday;
  final void Function()? onTap;

  Color _color(ColorPalette2 palette) => isRangeStart
      ? palette.primary
      : isRangeEnd
      ? palette.primary
      : Colors.transparent;

  Color _textColor(ColorPalette2 palette) {
    if (isSelected) {
      return palette.foregroundAccent;
    } else if (isToday) {
      return palette.foregroundPrimary;
    } else if (!thisMonth) {
      if (isDateInRange) {
        return palette.foregroundSecondary;
      }
      return palette.foregroundDisabled;
    }

    return palette.foreground;
  }

  BorderRadius get _borderRadius => isSelected
      ? BorderRadius.circular(24.0)
      : isRangeStart
      ? .all(.circular(24.0))
      : isRangeEnd
      ? .all(.circular(24.0))
      : .circular(0.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _color(palette),
          borderRadius: _borderRadius,
        ),
        child: Center(
          child: UiText2.m(
            day.toString(),
            color: _textColor(palette),
            textAlign: .center,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
