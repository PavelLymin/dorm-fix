enum NonWorkingDay {
  saturday(6),
  sunday(7);

  const NonWorkingDay(this.day);
  final int day;
}

class WorkingDateTime {
  const WorkingDateTime._();
  static final WorkingDateTime _instance = WorkingDateTime._();
  factory WorkingDateTime() => _instance;

  static const int _startHour = 8;
  static const int _countHours = 9;

  DateTime get today => .now();
  DateTime get endDay => today.add(const Duration(days: 6));

  int get startHour => _startHour;
  int get countHours => _countHours;

  DateTime get start => DateTime(today.year, today.month, today.day, startHour);
  DateTime get end =>
      DateTime(today.year, today.month, today.day, startHour + countHours - 1);

  List<DateTime> get startTimes => getWorkingHours(startHour, countHours - 1);
  List<int> get nonWorkingDaysInt =>
      NonWorkingDay.values.map((e) => e.day).toList();

  List<DateTime> getWorkingHours(int start, [int hours = _countHours]) {
    int length = (startHour + hours) - start;
    int minute = 0;
    return List.generate(length, (index) {
      int hour = index + start;
      DateTime date = DateTime(
        today.year,
        today.month,
        today.day,
        hour,
        minute,
      );
      return date;
    });
  }

  bool isEndBeforeOrSameStart(DateTime start, DateTime end) =>
      start.isAfter(end) || start.isAtSameMomentAs(end);

  DateTime endRelativeStart(DateTime start) =>
      start.add(const Duration(hours: 1));

  bool isValidate(DateTime start, DateTime end) {
    if (end.isBefore(start) && start.isAtSameMomentAs(end)) return false;

    return true;
  }
}
