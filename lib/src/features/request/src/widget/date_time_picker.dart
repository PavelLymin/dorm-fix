import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';
import 'time_menu_dialog.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late final RequestFormBloc _requestFormBloc;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return GroupedList(
      color: colorPalette.secondary,
      items: <GroupedListItem>[
        GroupedListItem(
          title: UiText.bodyMedium('Дата'),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              locale: const Locale('ru'),
            );
            _requestFormBloc.add(.upadteRequestForm(date: date));
          },
          content: _ContentDateTime(
            color: colorPalette.secondaryButton,
            dateOrTime: BlocBuilder<RequestFormBloc, RequestFormState>(
              buildWhen: (previous, current) =>
                  previous.currentFormModel.displayDate !=
                  current.currentFormModel.displayDate,
              builder: (context, state) =>
                  UiText.bodyMedium(state.currentFormModel.displayDate),
            ),
          ),
        ),
        GroupedListItem(
          title: UiText.bodyMedium('Время'),
          onTap: () => showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: _requestFormBloc,
              child: const TimeMenuDialog(),
            ),
          ),
          content: _ContentDateTime(
            color: colorPalette.secondaryButton,
            dateOrTime: BlocBuilder<RequestFormBloc, RequestFormState>(
              buildWhen: (previous, current) =>
                  previous.currentFormModel.displayTime !=
                  current.currentFormModel.displayTime,
              builder: (context, state) {
                return UiText.bodyMedium(state.currentFormModel.displayTime);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentDateTime extends StatelessWidget {
  const _ContentDateTime({required this.color, required this.dateOrTime});

  final Color color;
  final Widget dateOrTime;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: .circular(16)),
      child: Padding(
        padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 1),
        child: dateOrTime,
      ),
    );
  }
}
