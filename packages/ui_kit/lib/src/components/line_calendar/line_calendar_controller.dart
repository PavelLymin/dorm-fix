part of 'line_calendar.dart';

DateTime _truncateAndStripTimezone(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

extension YearMonthDay on DateTime {
  DateTime truncateAndStripTimezone() => _truncateAndStripTimezone(this);
}

class LineCalendarController extends ValueNotifier<DateTime> {
  LineCalendarController(DateTime date, {this.unUseWeekDays = const []})
    : super(date.truncateAndStripTimezone());

  final List<int> unUseWeekDays;

  @override
  set value(DateTime newValue) {
    newValue = newValue.truncateAndStripTimezone();
    if (!unUseWeekDays.contains(newValue.weekday)) {
      super.value = newValue;
    }
  }

  bool isWeekDay(DateTime date) => !unUseWeekDays.contains(date.weekday);
}
