import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class TimeMenuDialog extends StatefulWidget {
  const TimeMenuDialog({super.key});

  @override
  State<TimeMenuDialog> createState() => _TimeMenuDialogState();
}

class _TimeMenuDialogState extends State<TimeMenuDialog>
    with _TimeMenuDialogStateMixin {
  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return AlertDialog(
      title: UiText.bodyLarge('Выберите время'),
      backgroundColor: colorPalette.secondary,
      actions: [
        UiButton.filledPrimary(
          onPressed: () => context.pop(),
          label: UiText.bodyMedium('Отмена'),
        ),
        UiButton.filledPrimary(
          onPressed: _onPressedButton,
          label: UiText.bodyMedium('Далее'),
        ),
      ],
      content: Row(
        children: [
          UiText.bodyLarge('C'),
          const SizedBox(width: 8),
          Expanded(
            child: _TimeDropdownMenu(
              controller: _startTimeController,
              onSelected: (value) => setState(() {
                _onStartSelected(value);
              }),
              menuEntries: menuEntriesFrom,
            ),
          ),
          const SizedBox(width: 8),
          UiText.bodyLarge('до'),
          const SizedBox(width: 8),
          Expanded(
            child: _TimeDropdownMenu(
              enabled: _isEnabled,
              controller: _endTimeController,
              onSelected: (value) {
                _endTimeController.text = value.toString();
              },
              menuEntries: menuEntriesTo,
            ),
          ),
        ],
      ),
    );
  }
}

mixin _TimeMenuDialogStateMixin on State<TimeMenuDialog> {
  List<DropdownMenuEntry<int>> menuEntriesTo = [];
  late final List<DropdownMenuEntry<int>> menuEntriesFrom;
  late final RequestFormBloc _requestFormBloc;
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    menuEntriesFrom = _createMenuEntries();
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  List<DropdownMenuEntry<int>> _createMenuEntries([
    int start = WorkingTime.startWorkHour,
  ]) {
    final entries = WorkingTime.createWorkingHours(start)
        .map(
          (hour) => DropdownMenuEntry<int>(label: hour.toString(), value: hour),
        )
        .toList();
    return entries;
  }

  void _onStartSelected(int? value) {
    _endTimeController.clear();
    if (value != null) {
      _isEnabled = true;
      menuEntriesTo = _createMenuEntries(value + 1);
      _startTimeController.text = value.toString();
    } else {
      _isEnabled = false;
      menuEntriesTo = [];
    }
  }

  void _onPressedButton() {
    if (WorkingTime.isValidate(
      _startTimeController.text,
      _endTimeController.text,
    )) {
      _requestFormBloc.add(
        RequestFormEvent.setRequestFormValue(
          startTime: int.parse(_startTimeController.text),
          endTime: int.parse(_endTimeController.text),
        ),
      );
      context.pop();
    }
  }
}

class _TimeDropdownMenu extends StatelessWidget {
  const _TimeDropdownMenu({
    this.enabled = true,
    required this.controller,
    required this.menuEntries,
    required this.onSelected,
  });

  final bool enabled;
  final TextEditingController controller;
  final List<DropdownMenuEntry<int>> menuEntries;
  final ValueChanged<int?>? onSelected;

  @override
  Widget build(BuildContext context) {
    final appTypography = Theme.of(context).appTypography;
    final colorPalette = Theme.of(context).colorPalette;
    return DropdownMenu<int>(
      controller: controller,
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
