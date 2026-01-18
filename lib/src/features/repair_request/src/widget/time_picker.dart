import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with _TimePickerStateMixin {
  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return SizedBox(
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          UiDropDownMenu<DateTime>(
            controller: _startTime,
            selectOnly: true,
            onSelected: _onSelectedStartTime,
            textAlign: .center,
            showTrailingIcon: false,
            dropdownMenuEntries: _startTimes,
            initialSelection: _workingDateTime.start,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_right_alt,
            color: colorPalette.borderStrong,
            size: 48,
          ),
          const Spacer(),
          BlocBuilder<RequestFormBloc, RequestFormState>(
            buildWhen: (previous, current) =>
                previous.currentFormModel.startTime !=
                current.currentFormModel.startTime,
            builder: (_, state) {
              final startTime = state.currentFormModel.startTime;
              final endTime = state.currentFormModel.endTime;
              _onChangeStart(startTime, endTime);
              return UiDropDownMenu<DateTime>(
                controller: _endTime,
                selectOnly: true,
                onSelected: _onSelectedEndTime,
                textAlign: .center,
                showTrailingIcon: false,
                dropdownMenuEntries: _endTimes,
                initialSelection: _workingDateTime.end,
              );
            },
          ),
        ],
      ),
    );
  }
}

mixin _TimePickerStateMixin on State<TimePicker> {
  final _workingDateTime = WorkingDateTime();
  late final RequestFormBloc _requestFormBloc;
  late final TextEditingController _startTime;
  late final TextEditingController _endTime;
  late final List<DropdownMenuEntry<DateTime>> _startTimes;
  List<DropdownMenuEntry<DateTime>> _endTimes = [];

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    _requestFormBloc.add(
      .update(startTime: _workingDateTime.start, endTime: _workingDateTime.end),
    );

    _startTime = TextEditingController(
      text: '${_workingDateTime.start.hour}:00',
    );
    _endTime = TextEditingController(text: '${_workingDateTime.end.hour}:00');

    _startTimes = _startEntries();
    _endTimes = _endEntries(_workingDateTime.start.hour + 1);
  }

  List<DropdownMenuEntry<DateTime>> _startEntries() => _workingDateTime
      .startTimes
      .map((date) => DropdownMenuEntry(value: date, label: '${date.hour}:00'))
      .toList();

  List<DropdownMenuEntry<DateTime>> _endEntries(int start) => _workingDateTime
      .getWorkingHours(start)
      .map((date) => DropdownMenuEntry(value: date, label: '${date.hour}:00'))
      .toList();

  void _onSelectedStartTime(DateTime? value) {
    _requestFormBloc.add(.update(startTime: value!));
    _endTimes = _endEntries(value.hour + 1);
  }

  void _onSelectedEndTime(DateTime? value) {
    _requestFormBloc.add(.update(endTime: value!));
  }

  void _onChangeStart(DateTime? start, DateTime? end) {
    if (start == null || end == null) return;
    if (_workingDateTime.isEndBeforeOrSameStart(start, end)) {
      final end = _workingDateTime.endRelativeStart(start);
      _requestFormBloc.add(.update(endTime: end));
      _endTime.text = '${end.hour}:00';
    }
  }
}
