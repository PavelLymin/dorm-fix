import '../../../../ui.dart';

class _DayCell {
  const _DayCell({required this.date, required this.thisMonth});

  final DateTime date;
  final bool thisMonth;
}

class PagePicker extends StatefulWidget {
  const PagePicker({
    super.key,
    required this.start,
    required this.end,
    required this.initial,
    required this.controller,
    required this.calendar,
    required this.currentDate,
  });

  final DateTime start;
  final DateTime end;
  final DateTime initial;
  final PageController controller;
  final CalendarController calendar;
  final ValueNotifier<DateTime> currentDate;

  @override
  State<PagePicker> createState() => _PagePickerState();
}

class _PagePickerState extends State<PagePicker> with _PagePickerStateMixin {
  static const double _gapX = 24.0;
  static const double _gapY = 8.0;

  Widget _buildWeekRangeBackground(
    List<_DayCell> week,
    double cellWidth,
    double cellHeight,
  ) {
    final startCol = rangeStartCol(week);
    final endCol = rangeEndCol(week);

    if (startCol == null || endCol == null) return const SizedBox.shrink();

    final left = startCol * (cellWidth + _gapX);
    final width =
        (endCol - startCol + 1) * cellWidth + (endCol - startCol) * _gapX;

    return Positioned(
      left: left,
      top: 0,
      width: width,
      height: cellHeight,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFFD1EEE3),
          borderRadius: .all(.circular(24.0)),
        ),
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    _DayCell cell,
    double cellWidth,
    double cellHeight,
  ) {
    final isSelected = _isDateSelected(cell.date);
    final isRangeStart = _isRangeStart(cell.date);
    final isRangeEnd = _isRangeEnd(cell.date);
    final isDateInRange = _isDateInRange(cell.date);
    final isToday = _isToday(cell.date);

    return SizedBox(
      width: cellWidth,
      height: cellHeight,
      child: Entry(
        day: cell.date.day.toString(),
        thisMonth: cell.thisMonth,
        onTap: () => widget.calendar.selectDate(cell.date),
        isSelected: isSelected,
        isRangeStart: isRangeStart,
        isRangeEnd: isRangeEnd,
        isDateInRange: isDateInRange,
        isToday: isToday,
      ),
    );
  }

  Widget buildItem(BuildContext context, int page) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final monthDate = pageMonth(widget.start, page);
    final weeks = _buildWeeks(monthDate);

    const maxWeeks = 6;
    const weekdayHeight = 24.0;

    return LayoutBuilder(
      builder: (_, constraints) {
        final cellWidth = (constraints.maxWidth - _gapX * 6) / 7;
        final cellHeight =
            (constraints.maxHeight - weekdayHeight - _gapY * maxWeeks) /
            maxWeeks;
        return Column(
          mainAxisSize: .min,
          children: [
            SizedBox(
              height: weekdayHeight,
              child: Row(
                children: [
                  for (int i = 0; i < 7; i++) ...[
                    SizedBox(
                      width: cellWidth,
                      child: Center(
                        child: UiText2.m(
                          weekdays[i],
                          color: palette.foregroundSecondary,
                          textAlign: .center,
                        ),
                      ),
                    ),
                    if (i != 6) const SizedBox(width: _gapX),
                  ],
                ],
              ),
            ),
            const SizedBox(height: _gapY),
            Expanded(
              child: Column(
                mainAxisSize: .min,
                children: [
                  for (int week = 0; week < weeks.length; week++) ...[
                    SizedBox(
                      height: cellHeight,
                      child: ListenableBuilder(
                        listenable: widget.calendar,
                        builder: (context, child) {
                          return Stack(
                            children: [
                              if (_weekHasRange(weeks[week]))
                                _buildWeekRangeBackground(
                                  weeks[week],
                                  cellWidth,
                                  cellHeight,
                                ),
                              Row(
                                mainAxisSize: .min,
                                children: [
                                  for (int i = 0; i < 7; i++) ...[
                                    _buildDayCell(
                                      context,
                                      weeks[week][i],
                                      cellWidth,
                                      cellHeight,
                                    ),
                                    if (i != 6) const SizedBox(width: _gapX),
                                  ],
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (week != weeks.length - 1) const SizedBox(height: _gapY),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return SizedBox(
      height: 212.0,
      child: ColoredBox(
        color: palette.card,
        child: PageView.builder(
          onPageChanged: (page) =>
              widget.currentDate.value = pageMonth(widget.start, page),
          scrollDirection: .horizontal,
          controller: widget.controller,
          itemBuilder: buildItem,
          itemCount: widget.end.difference(widget.start).inDays + 1,
        ),
      ),
    );
  }
}

mixin _PagePickerStateMixin on State<PagePicker> {
  List<String> weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  final today = DateTime.now();

  DateTime pageMonth(DateTime start, int page) =>
      DateTime(start.year, start.month + page, 1);

  bool _isSameDay(DateTime date1, DateTime? date2) {
    if (date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isToday(DateTime date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;

  bool _isDateSelected(DateTime date) =>
      _isSameDay(date, widget.calendar.start) ||
      _isSameDay(date, widget.calendar.end);

  bool _isRangeStart(DateTime date) =>
      widget.calendar.start != null && _isSameDay(date, widget.calendar.start);

  bool _isRangeEnd(DateTime date) =>
      widget.calendar.end != null && _isSameDay(date, widget.calendar.end);

  bool _isDateInRange(DateTime date) {
    if (!widget.calendar.multiDay ||
        widget.calendar.start == null ||
        widget.calendar.end == null) {
      return false;
    }

    return date.isAfter(widget.calendar.start!) &&
        date.isBefore(widget.calendar.end!);
  }

  List<List<_DayCell>> _buildWeeks(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final leadingEmpty = firstDayOfMonth.weekday - 1;
    final totalDays = leadingEmpty + lastDayOfMonth.day;
    final tralingEmpty = (7 - (totalDays % 7)) % 7;
    final totalCells = totalDays + tralingEmpty;

    final startCell = DateTime(
      firstDayOfMonth.year,
      firstDayOfMonth.month,
      1 - leadingEmpty,
    );

    final cells = List.generate(totalCells, (index) {
      final day = DateTime(
        startCell.year,
        startCell.month,
        startCell.day + index,
      );
      return _DayCell(date: day, thisMonth: day.month == date.month);
    });

    return List.generate(
      cells.length ~/ 7,
      (index) => cells.sublist(index * 7, index * 7 + 7),
    );
  }

  int? rangeStartCol(List<_DayCell> week) {
    for (var i = 0; i < week.length; i++) {
      final d = week[i].date;
      if (_isDateInRange(d) || _isRangeStart(d) || _isRangeEnd(d)) {
        return i;
      }
    }
    return null;
  }

  int? rangeEndCol(List<_DayCell> week) {
    for (var i = week.length - 1; i >= 0; i--) {
      final d = week[i].date;
      if (_isDateInRange(d) || _isRangeStart(d) || _isRangeEnd(d)) {
        return i;
      }
    }
    return null;
  }

  bool _weekHasRange(List<_DayCell> week) =>
      rangeStartCol(week) != null && rangeEndCol(week) != null;
}
