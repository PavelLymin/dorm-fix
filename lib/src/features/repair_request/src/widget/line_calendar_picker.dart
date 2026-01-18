// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ui_kit/ui.dart';
// import '../../request.dart';
// import 'time_menu_dialog.dart';

// class DateTimePicker extends StatefulWidget {
//   const DateTimePicker({super.key});

//   @override
//   State<DateTimePicker> createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {
//   late final RequestFormBloc _requestFormBloc;

// @override
// void initState() {
//   super.initState();
//   _requestFormBloc = context.read<RequestFormBloc>();
// }

//   @override
//   Widget build(BuildContext context) {
//     final colorPalette = Theme.of(context).colorPalette;
//     return GroupedList(
//       divider: .indented(),
//       items: <GroupedListItem>[
//         GroupedListItem(
//           title: 'Дата',
//           onTap: () async {
//             final date = await showDatePicker(
//               context: context,
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//               locale: const Locale('ru'),
//             );
//             _requestFormBloc.add(.updateRequestForm(date: date));
//           },
//           content: _ContentDateTime(
//             color: colorPalette.secondary,
//             dateOrTime: BlocBuilder<RequestFormBloc, RequestFormState>(
//               buildWhen: (previous, current) =>
//                   previous.currentFormModel.displayDate !=
//                   current.currentFormModel.displayDate,
//               builder: (context, state) =>
//                   UiText.bodyMedium(state.currentFormModel.displayDate),
//             ),
//           ),
//         ),
//         GroupedListItem(
//           title: 'Время',
//           onTap: () => showDialog(
//             context: context,
//             builder: (context) => BlocProvider.value(
//               value: _requestFormBloc,
//               child: const TimeMenuDialog(),
//             ),
//           ),
//           content: _ContentDateTime(
//             color: colorPalette.secondary,
//             dateOrTime: BlocBuilder<RequestFormBloc, RequestFormState>(
//               buildWhen: (previous, current) =>
//                   previous.currentFormModel.displayTime !=
//                   current.currentFormModel.displayTime,
//               builder: (context, state) {
//                 return UiText.bodyMedium(state.currentFormModel.displayTime);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

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
    return UiCard.standart(
      padding: AppPadding.allSmall,
      borderRadius: .all(.circular(16.0)),
      child: LineCalendar(
        today: _workingDateTime.today,
        start: _workingDateTime.today,
        end: _workingDateTime.endDay,
        controller: _controller,
      ),
    );
  }
}
