import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../repair_request/request.dart';

class RequestFilter extends StatelessWidget {
  const RequestFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      spacing: 16.0,
      children: [
        Expanded(
          child: UiDropDownButton<StatusEnum>(
            selectOnly: true,
            onSelected: (value) => context.read<RepairWatcherBloc>().add(
              .get(uid: true, status: value),
            ),
            hintText: 'Статус',
            dropdownMenuEntries: StatusEnum.values
                .map(
                  (e) => DropdownMenuEntry(
                    value: e,
                    label: e.value,
                    style: ButtonStyle(textStyle: .all(typography.m)),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: UiButton.filledPrimary(
            onPressed: () {},
            label: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                UiText2.m('Дата'),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: .all(palette.card),
              iconColor: .all(palette.foreground),
            ),
          ),
        ),
      ],
    );
  }
}
