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
        ValueListenableBuilder(
          valueListenable: _enabledButton,
          builder: (_, value, _) {
            return UiButton.filledPrimary(
              enabled: value,
              onPressed: _onPressedButton,
              label: UiText.bodyMedium('Далее'),
            );
          },
        ),
      ],
      content: Row(
        children: [
          UiText.bodyLarge('C'),
          const SizedBox(width: 8),
          Expanded(
            child: _TimeDropdownMenu(
              controller: _startTimeController,
              onSelected: _onStartSelected,
              menuEntries: _startTimes,
            ),
          ),
          const SizedBox(width: 8),
          UiText.bodyLarge('до'),
          const SizedBox(width: 8),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _enabledTimeMenu,
              builder: (_, value, _) {
                return _TimeDropdownMenu(
                  enabled: value,
                  controller: _endTimeController,
                  onSelected: _onEndSelected,
                  menuEntries: _endTimes,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

mixin _TimeMenuDialogStateMixin on State<TimeMenuDialog> {
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final ValueNotifier<bool> _enabledTimeMenu = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _enabledButton = ValueNotifier<bool>(false);
  List<DropdownMenuEntry<int>> _endTimes = [];
  late final List<DropdownMenuEntry<int>> _startTimes;

  @override
  void initState() {
    super.initState();
    _startTimes = _createMenuEntries();
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  List<DropdownMenuEntry<int>> _createMenuEntries([
    int start = WorkingTime.startWorkHour,
  ]) => WorkingTime.createWorkingHours(start)
      .map((hour) => DropdownMenuEntry(label: hour.toString(), value: hour))
      .toList();

  void _onStartSelected(int? value) {
    if (value != null) {
      _endTimeController.clear();
      _endTimes = _createMenuEntries(value + 1);
      _enabledTimeMenu.value = true;
      _enabledButton.value = false;
    }
  }

  void _onEndSelected(int? value) {
    if (value != null) {
      _enabledButton.value = true;
    }
  }

  void _onPressedButton() {
    context.read<RequestFormBloc>().add(
      .upadteRequestForm(
        startTime: _startTimeController.text,
        endTime: _endTimeController.text,
      ),
    );
    context.pop();
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
      expandedInsets: const .all(0),
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
