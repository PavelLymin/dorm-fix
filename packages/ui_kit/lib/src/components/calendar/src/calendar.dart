import '../../../../ui.dart';
import 'controller.dart';
import 'header.dart';
import 'page_picker.dart';

class UiCalendar extends StatefulWidget {
  UiCalendar({
    super.key,
    DateTime? start,
    DateTime? end,
    DateTime? initial,
    Duration? duration,
    CalendarController? controller,
  }) : start = start ?? DateTime(1900),
       end = end ?? DateTime(2100),
       initial = initial ?? .now(),
       duration = const Duration(milliseconds: 200),
       controller = controller ?? CalendarController(multiDay: false);

  final DateTime start;
  final DateTime end;
  final DateTime initial;
  final Duration duration;
  final CalendarController controller;

  @override
  State<UiCalendar> createState() => _UiCalendarState();
}

class _UiCalendarState extends State<UiCalendar> {
  late PageController _controller;
  late final ValueNotifier<DateTime> _currentDate;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.start.difference(widget.initial).inDays,
    );
    _currentDate = ValueNotifier(widget.initial);
  }

  @override
  void didUpdateWidget(covariant UiCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != oldWidget.start || widget.end != oldWidget.end) {
      _controller.dispose();
      _controller = PageController(
        initialPage: widget.start.difference(widget.initial).inDays,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext() =>
      _controller.nextPage(duration: widget.duration, curve: Curves.ease);

  void _onPrevious() =>
      _controller.previousPage(duration: widget.duration, curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 20.0,
      children: [
        Header(
          onPrevious: _onPrevious,
          onNext: _onNext,
          currentDate: _currentDate,
        ),
        PagePicker(
          start: widget.start,
          end: widget.end,
          initial: widget.initial,
          controller: _controller,
          calendar: widget.controller,
          currentDate: _currentDate,
        ),
      ],
    );
  }
}
