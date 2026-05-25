import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../dormitory/dormitory.dart';
import '../../../../repair_request/request.dart';

class RequestFilter extends StatefulWidget {
  const RequestFilter({super.key, required this.specId});

  final int specId;

  @override
  State<RequestFilter> createState() => _RequestFilterState();
}

class _RequestFilterState extends State<RequestFilter> {
  @override
  void initState() {
    super.initState();
    context.read<DormitoryBloc>().add(.get());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final typography = theme.appTypography2;
    final local = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      spacing: 16.0,
      children: [
        Expanded(
          child: BlocBuilder<DormitoryBloc, DormitoryState>(
            builder: (context, state) {
              return UiDropDownButton<int>(
                selectOnly: true,
                onSelected: (value) => context.read<RepairWatcherBloc>().add(
                  .get(specId: widget.specId, dormId: value),
                ),
                hintText: local.dormitory,
                dropdownMenuEntries: state.dormitories
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e.id,
                        label: '№${e.number}',
                        style: ButtonStyle(textStyle: .all(typography.m)),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
        Expanded(
          child: UiButton.filledPrimary(
            onPressed: () {},
            label: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                UiText2.m(local.date),
                const Icon(UiIcons.chevronDown),
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
