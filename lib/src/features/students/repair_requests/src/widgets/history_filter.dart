import 'package:ui_kit/ui.dart';

import '../../../../repair_request/request.dart';

class HistoryFilter extends StatelessWidget {
  const HistoryFilter({super.key, required this.bloc});

  final RepairRequestBloc bloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    return SliverPadding(
      padding: .only(top: 16.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          spacing: 16.0,
          children: [
            Expanded(
              child: UiDropDownButton<StatusEnum>(
                selectOnly: true,
                onSelected: (value) => bloc.add(.get(uid: true, status: value)),
                trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                selectedTrailingIcon: const Icon(
                  Icons.keyboard_arrow_up_rounded,
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
        ),
      ),
    );
  }
}
