import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:dorm_fix/src/features/authentication/authentication.dart';
import 'package:dorm_fix/src/features/profile/src/state_management/student_bloc/student_bloc.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
import '../../room/state_management/room_search_bloc/room_search_bloc_bloc.dart';

class RoomModalSheet extends StatefulWidget {
  const RoomModalSheet({super.key, required this.dormitroy});
  final DormitoryEntity dormitroy;

  @override
  State<RoomModalSheet> createState() => _RoomModalSheetState();
}

class _RoomModalSheetState extends State<RoomModalSheet> {
  late final TextEditingController _roomController;
  late final StudentBloc _studentBloc;
  bool isEnabled = false;
  int roomId = 0;

  void _changeButtonState() {
    setState(() {
      if (_roomController.text.isEmpty) isEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _roomController = TextEditingController();
    _roomController.addListener(_changeButtonState);

    final logger = DependeciesScope.of(context).logger;
    final studentRepository = DependeciesScope.of(context).studentRepository;
    _studentBloc = StudentBloc(
      logger: logger,
      studentRepository: studentRepository,
    );
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return BlocProvider(
      create: (context) => _studentBloc,
      child: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          state.mapOrNull(
            error: (error) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.message))),
            created: (_) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ),
          );
        },
        child: SafeArea(
          child: Padding(
            padding: AppPadding.symmetricIncrement(horizontal: 2),
            child: Column(
              children: [
                const SizedBox(height: 16),
                UiText.titleLarge('Номер комнаты'),
                const SizedBox(height: 16),
                UiTextField.standard(
                  controller: _roomController,
                  style: UiTextFieldStyle(hintText: 'Поиск комнаты...'),
                  onChanged: context.read<RoomSearcBloc>().onTextChanged.add,
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: BlocBuilder<RoomSearcBloc, RoomSearchState>(
                    builder: (context, state) {
                      return state.maybeMap(
                        orElse: () => const Text('Введите текст в поле'),
                        loading: (_) => CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(
                            context,
                          ).colorPalette.primary.withValues(alpha: .38),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isEnabled = true;
                                      roomId = room.id;
                                    });
                                  },
                                ),
                            ],
                          );
                        },
                        searchEmpty: (_) => Text('Такой комнаты не существует'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: UiButton.filledPrimary(
                    onPressed: () {
                      _studentBloc.add(
                        StudentEvent.create(
                          student: CreatedStudentEntity(
                            user: context
                                .read<AuthBloc>()
                                .state
                                .authenticatedOrNull!,
                            dormitoryId: widget.dormitroy.id,
                            roomId: roomId,
                          ),
                        ),
                      );
                    },
                    enabled: isEnabled,
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
          ),
        ),
      ),
    );
  }
}
