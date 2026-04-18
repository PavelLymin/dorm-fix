import 'package:ui_kit/ui.dart';

class CalendarController with ChangeNotifier {
  CalendarController({required this.multiDay});

  final bool multiDay;

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get start => _startDate;
  DateTime? get end => _endDate;
  DateTime? get selectedDate => _startDate;

  void selectDate(DateTime date) {
    if (multiDay) {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = date;
        _endDate = null;
      } else if (_startDate != null && _endDate == null) {
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          _endDate = date;
        }
      }
    } else {
      _startDate = date;
      _endDate = null;
    }

    notifyListeners();
  }
}
