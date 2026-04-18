import 'package:ui_kit/ui.dart';

class CalendarPreview extends StatefulWidget {
  const CalendarPreview({super.key});

  @override
  State<CalendarPreview> createState() => _CalendarPreviewState();
}

class _CalendarPreviewState extends State<CalendarPreview> {
  late final CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController(multiDay: true);
  }

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiCalendar(
        controller: _calendarController,
        start: .now(),
        end: DateTime(2100),
        initial: .now(),
      ),
    );
  }
}
