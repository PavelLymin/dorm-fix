part of 'line_calendar.dart';

DateTime _truncateAndStripTimezone(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

extension YearMonthDay on DateTime {
  DateTime truncateAndStripTimezone() => _truncateAndStripTimezone(this);
}

class LineCalendarController extends ChangeNotifier {
  LineCalendarController(DateTime initial, {this.unUseWeekDays = const []}) {
    _initial = _initDateTime(initial, unUseWeekDays);
  }

  final List<int> unUseWeekDays;
  DateTime? _initial;

  DateTime? get initial => _initial;

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

  set selectedDate(DateTime newValue) {
    newValue = newValue.truncateAndStripTimezone();
    if (!unUseWeekDays.contains(newValue.weekday)) {
      _initial = newValue;
    }
    notifyListeners();
  }

  bool isUseDay(DateTime date) => !unUseWeekDays.contains(date.weekday);
}
