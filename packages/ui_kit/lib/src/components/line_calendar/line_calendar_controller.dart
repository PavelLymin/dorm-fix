import 'package:ui_kit/ui.dart';

DateTime _truncateAndStripTimezone(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

extension YearMonthDay on DateTime {
  DateTime truncateAndStripTimezone() => _truncateAndStripTimezone(this);
}

class LineCalendarController extends ValueNotifier<DateTime> {
  LineCalendarController(DateTime date)
    : super(date.truncateAndStripTimezone());
}
