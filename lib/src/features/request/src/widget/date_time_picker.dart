import 'package:ui_kit/ui.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return GroupedList(
      color: colorPalette.secondary,
      items: <GroupedListItem>[
        GroupedListItem(
          title: UiText.bodyMedium('Дата'),
          onTap: () => showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            locale: const Locale('ru'),
          ),
          content: _ContentDateTime(
            color: colorPalette.secondaryButton,
            dateOrTime: 'Date',
          ),
        ),
        GroupedListItem(
          title: UiText.bodyMedium('Время'),
          onTap: () {},
          content: _ContentDateTime(
            color: colorPalette.secondaryButton,
            dateOrTime: 'Time',
          ),
        ),
      ],
    );
  }
}

class _ContentDateTime extends StatelessWidget {
  const _ContentDateTime({required this.color, required this.dateOrTime});

  final Color color;
  final String dateOrTime;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: .circular(16)),
      child: Padding(
        padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 1),
        child: UiText.bodyMedium(dateOrTime),
      ),
    );
  }
}
