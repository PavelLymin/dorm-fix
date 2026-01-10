import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../room/room.dart';
import '../../../dormitory/src/model/dormitory.dart';

class RoomModalSheet extends StatefulWidget {
  const RoomModalSheet({super.key, required this.dormitory});
  final DormitoryEntity dormitory;

  @override
  State<RoomModalSheet> createState() => _RoomModalSheetState();
}

class _RoomModalSheetState extends State<RoomModalSheet> {
  final _isEnabled = ValueNotifier<bool>(false);
  final _roomController = TextEditingController();
  int _roomId = 0;

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  void _onSave() {
    context.router.replace(
      NamedRoute(
        'ExtraPersonDataScreen',
        params: {'dormitoryId': widget.dormitory.id, 'roomId': _roomId},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return SafeArea(
      child: Padding(
        padding: AppPadding.onlyIncrement(right: 2, left: 2, bottom: 4),
        child: Column(
          children: [
            const SizedBox(height: 16),
            UiText.titleLarge('Номер комнаты'),
            const SizedBox(height: 16),
            UiTextField.standard(
              controller: _roomController,
              keyboardType: .text,
              style: UiTextFieldStyle(
                hintText: 'Поиск комнаты...',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: context.read<RoomSearcBloc>().onTextChanged.add,
            ),
            const SizedBox(height: 16),
            BlocBuilder<RoomSearcBloc, RoomSearchState>(
              builder: (context, state) {
                return state.maybeMap(
                  orElse: () => UiText.bodyMedium('Введите текст в поле'),
                  loading: (_) => SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: color.primary.withValues(alpha: .38),
                    ),
                  ),
                  error: (state) => Text(state.message),
                  searchPopulated: (state) {
                    final rooms = state.rooms;
                    return GroupedList(
                      color: color.secondaryButton,
                      items: [
                        for (var room in rooms)
                          GroupedListItem(
                            title: UiText.bodyMedium(
                              room.number,
                              style: TextStyle(fontWeight: .bold),
                            ),
                            onTap: () {
                              _roomController.text = room.number;
                              _isEnabled.value = true;
                              _roomId = room.id;
                            },
                          ),
                      ],
                    );
                  },
                  searchEmpty: (_) => Text('Такой комнаты не существует'),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: .infinity,
              height: 48,
              child: ValueListenableBuilder(
                valueListenable: _isEnabled,
                builder: (_, value, _) {
                  return UiButton.filledPrimary(
                    onPressed: _onSave,
                    enabled: value,
                    label: UiText.titleLarge('Сохранить'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: .infinity,
              height: 48,
              child: UiButton.filledPrimary(
                onPressed: () => context.router.pop(),
                label: UiText.titleLarge('Отмена'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
