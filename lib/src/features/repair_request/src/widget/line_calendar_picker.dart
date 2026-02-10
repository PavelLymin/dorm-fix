import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class LineCalendarPicker extends StatefulWidget {
  const LineCalendarPicker({super.key});

  @override
  State<LineCalendarPicker> createState() => _LineCalendarPickerState();
}

class _LineCalendarPickerState extends State<LineCalendarPicker> {
  late final LineCalendarController _controller;
  final _workingDateTime = WorkingDateTime();

  @override
  void initState() {
    super.initState();
    _controller = LineCalendarController(
      _workingDateTime.today,
      unUseWeekDays: _workingDateTime.nonWorkingDaysInt,
    );
    _controller.addListener(_onChange);
  }

  void _onChange() {
    context.read<RequestFormBloc>().add(.update(date: _controller.value));
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestFormBloc, RequestFormState>(
      listenWhen: (previous, current) =>
          previous.currentFormModel.date != current.currentFormModel.date,
      listener: (context, state) => state.mapOrNull(
        initial: (state) => _controller.value = state.currentFormModel.date,
      ),
      child: UiCard.standart(
        padding: AppPadding.allSmall,
        borderRadius: .all(.circular(16.0)),
        child: LineCalendar(
          today: _workingDateTime.today,
          start: _workingDateTime.today,
          end: _workingDateTime.endDay,
          controller: _controller,
        ),
      ),
    );
  }
}
