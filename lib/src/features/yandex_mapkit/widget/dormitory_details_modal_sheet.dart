import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/widget/room_modal_sheet.dart';

import '../../../app/widget/dependencies_scope.dart';
import '../../room/state_management/room_search_bloc/room_search_bloc_bloc.dart';

class DormitoryDetailsModalSheet extends StatefulWidget {
  const DormitoryDetailsModalSheet({
    super.key,
    required DormitoryEntity dormitory,
  }) : _dormitory = dormitory;
  final DormitoryEntity _dormitory;

  @override
  State<DormitoryDetailsModalSheet> createState() =>
      _DormitoryModalSheetState();
}

class _DormitoryModalSheetState extends State<DormitoryDetailsModalSheet> {
  late final RoomSearcBloc _roomSearcBloc;

  @override
  void initState() {
    super.initState();
    final logger = DependeciesScope.of(context).logger;
    final roomRepository = DependeciesScope.of(context).roomRepository;
    _roomSearcBloc = RoomSearcBloc(
      logger: logger,
      roomRepository: roomRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _roomSearcBloc,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: AppPadding.symmetricIncrement(horizontal: 2),
          child: Column(
            children: [
              const SizedBox(height: 16),
              UiText.titleLarge(widget._dormitory.name),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: UiButton.filledPrimary(
                  onPressed: () {
                    _showRoomModalSheet(context, widget._dormitory);
                  },
                  label: UiText.titleLarge('Выбрать'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoomModalSheet(BuildContext context, DormitoryEntity dormitory) {
    _roomSearcBloc.add(
      RoomSearchEvent.chooseDormitory(dormitoryId: dormitory.id),
    );
    showUiBottomSheet(
      context,
      BlocProvider.value(
        value: _roomSearcBloc,
        child: RoomModalSheet(dormitroy: dormitory),
      ),
      maxHeight: MediaQuery.sizeOf(context).height * 0.7,
    );
  }
}
