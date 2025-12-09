import 'package:dorm_fix/src/features/room/state_management/room_search_bloc/room_search_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';

import '../../../app/widget/dependencies_scope.dart';

class RoomModalSheet extends StatefulWidget {
  const RoomModalSheet({super.key, required DormitoryEntity dormitory})
    : _dormitory = dormitory;
  final DormitoryEntity _dormitory;

  @override
  State<RoomModalSheet> createState() => _RoomModalSheetState();
}

class _RoomModalSheetState extends State<RoomModalSheet> {
  late final TextEditingController _roomController;
  late final RoomSearcBloc _roomSearcBloc;

  @override
  void initState() {
    super.initState();
    _roomController = TextEditingController();
    _roomSearcBloc = DependeciesScope.of(context).roomSearcBloc;

    _roomSearcBloc.add(
      RoomSearchEvent.chooseDormitory(dormitoryId: widget._dormitory.id),
    );
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('widget._dormitory.id ${widget._dormitory.id}');
    return BlocProvider.value(
      value: _roomSearcBloc,
      child: Padding(
        padding: AppPadding.symmetricIncrement(horizontal: 2),
        child: Column(
          children: [
            const SizedBox(height: 16),
            UiText.titleLarge('Номер комнаты'),
            const SizedBox(height: 16),
            UiTextField.standard(
              controller: _roomController,
              style: UiTextFieldStyle(hintText: 'Введите текст'),
              onChanged: _roomSearcBloc.onTextChanged.add,
            ),
            Column(
              children: [
                BlocBuilder<RoomSearcBloc, RoomSearchState>(
                  builder: (context, state) {
                    return state.maybeMap(
                      orElse: () => SizedBox.shrink(),
                      loading: (_) => CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(
                          context,
                        ).colorPalette.primary.withValues(alpha: .38),
                      ),
                      error: (state) => Text(state.message),
                      noTerm: (_) => Text('Введите текст'),
                      searchPopulated: (state) {
                        final rooms = state.rooms;
                        return ListView.builder(
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            final dormitory = rooms[index];
                            return TextButton(
                              onPressed: () {},
                              child: Text(dormitory.number),
                            );
                          },
                        );
                      },
                      searchEmpty: (_) =>
                          Text('Такого общежития не существует'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: UiButton.filledPrimary(
                    onPressed: () {},
                    label: UiText.titleLarge('Сохранить'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: UiButton.filledPrimary(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: UiText.titleLarge('Отмена'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
