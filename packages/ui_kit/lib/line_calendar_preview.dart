import 'ui.dart';

class LineCalendarPreview extends StatefulWidget {
  const LineCalendarPreview({super.key});

  @override
  State<LineCalendarPreview> createState() => _LineCalendarPreviewState();
}

class _LineCalendarPreviewState extends State<LineCalendarPreview> {
  final _today = DateTime.now();
  late final LineCalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LineCalendarController(_today, unUseWeekDays: [6, 7]);
  }

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: LineCalendar(
        controller: _controller,
        start: _today,
        end: _today.add(const Duration(days: 6)),
        today: _today,
      ),
    );
  }
}
