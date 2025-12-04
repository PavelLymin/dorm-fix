import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

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
            _requestFormBloc.add(
              RequestFormEvent.setRequestFormValue(date: date),
            );
          },
          content: _ContentDateTime(
            color: colorPalette.secondaryButton,
            dateOrTime: BlocBuilder<RequestFormBloc, RequestFormState>(
              builder: (context, state) {
                return UiText.bodyMedium(state.date.toString());
              },
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
              builder: (context, state) {
                return UiText.bodyMedium(
                  '${state.startTime.toString()} - ${state.endTime.toString()}',
                );
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

class TimeMenuDialog extends StatefulWidget {
  const TimeMenuDialog({super.key});

  @override
  State<TimeMenuDialog> createState() => _TimeMenuDialogState();
}

class _TimeMenuDialogState extends State<TimeMenuDialog> {
  static const startWork = 8;
  static const workingHours = 9;
  bool _isEnabled = false;
  late final List<DropdownMenuEntry<int>> menuEntriesFrom;
  List<DropdownMenuEntry<int>> menuEntriesTo = [];
  late final RequestFormBloc _requestFormBloc;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    menuEntriesFrom = createMenuEntries(startWork);
  }

  List<DropdownMenuEntry<int>> createMenuEntries(int start) {
    int length = (startWork + workingHours) - start;
    return List.generate(length, (index) {
      int hour = index + start;
      return DropdownMenuEntry<int>(label: hour.toString(), value: hour);
    });
  }

  void _onStartSelected(int? value) {
    if (value != null) {
      _isEnabled = true;
      menuEntriesTo = createMenuEntries(value + 1);
    } else {
      _isEnabled = false;
      menuEntriesTo = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: UiText.bodyLarge('Выберите время'),
      content: Row(
        children: [
          UiText.bodyLarge('C'),
          const SizedBox(width: 8),
          Expanded(
            child: _TimeDropdownMenu(
              enabled: true,
              onSelected: (value) {
                setState(() {
                  _onStartSelected(value);
                });
                _requestFormBloc.add(
                  RequestFormEvent.setRequestFormValue(
                    startTime: value,
                    endTime: null,
                  ),
                );
              },
              menuEntries: menuEntriesFrom,
            ),
          ),
          const SizedBox(width: 8),
          UiText.bodyLarge('до'),
          const SizedBox(width: 8),
          Expanded(
            child: _TimeDropdownMenu(
              enabled: _isEnabled,
              onSelected: (value) => _requestFormBloc.add(
                RequestFormEvent.setRequestFormValue(endTime: value),
              ),
              menuEntries: menuEntriesTo,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeDropdownMenu extends StatelessWidget {
  const _TimeDropdownMenu({
    required this.enabled,
    required this.menuEntries,
    required this.onSelected,
  });

  final bool enabled;
  final List<DropdownMenuEntry<int>> menuEntries;
  final ValueChanged<int?>? onSelected;

  @override
  Widget build(BuildContext context) {
    final appTypography = Theme.of(context).appTypography;
    final colorPalette = Theme.of(context).colorPalette;
    return DropdownMenu<int>(
      enabled: enabled,
      onSelected: onSelected,
      expandedInsets: const EdgeInsets.all(0),
      dropdownMenuEntries: menuEntries,
      textAlign: .center,
      textStyle: appTypography.bodyLarge,
      enableFilter: false,
      showTrailingIcon: true,
      menuStyle: MenuStyle(
        maximumSize: const WidgetStatePropertyAll<Size>(Size(.infinity, 256)),
        backgroundColor: WidgetStatePropertyAll<Color?>(colorPalette.secondary),
        side: const WidgetStatePropertyAll<BorderSide>(
          BorderSide(style: .none),
        ),
        shape: const WidgetStatePropertyAll<OutlinedBorder?>(
          RoundedRectangleBorder(borderRadius: .all(.circular(24))),
        ),
      ),
    );
  }
}
