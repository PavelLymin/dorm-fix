part of 'line_calendar.dart';

DateTime _truncateAndStripTimezone(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

extension YearMonthDay on DateTime {
  DateTime truncateAndStripTimezone() => _truncateAndStripTimezone(this);
}

class LineCalendarController extends ValueNotifier<DateTime> {
  LineCalendarController(DateTime date, {this.unUseWeekDays = const []})
    : super(_initDateTime(date, unUseWeekDays));

  final List<int> unUseWeekDays;

  static DateTime _initDateTime(
    DateTime date, [
    List<int> unUseWeekDays = const [],
  ]) {
    date = date.truncateAndStripTimezone();
    for (var weekDay in unUseWeekDays) {
      if (weekDay == date.weekday) {
        date = date.add(const Duration(days: 1));
      }
    }
    return date;
  }

  @override
  set value(DateTime newValue) {
    newValue = newValue.truncateAndStripTimezone();
    if (!unUseWeekDays.contains(newValue.weekday)) {
      super.value = newValue;
    }
  }

  bool isWeekDay(DateTime date) => !unUseWeekDays.contains(date.weekday);
}
