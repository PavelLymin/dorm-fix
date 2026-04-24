import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';
import '../../../dormitory/dormitory.dart';
import '../../room.dart';

class SearchRooms extends StatelessWidget {
  const SearchRooms({super.key, required this.dormitory, required this.rooms});

  final DormitoryEntity dormitory;
  final List<RoomEntity> rooms;

  @override
  Widget build(BuildContext context) => SliverFixedExtentList(
    itemExtent: 48.0,
    delegate: SliverChildBuilderDelegate(
      (_, index) => Padding(
        padding: index == 0
            ? AppInsets.itemDense.copyWith(top: 0)
            : index == rooms.length - 1
            ? AppInsets.itemDense.copyWith(bottom: 0)
            : AppInsets.item,
        child: _Item(dormitory: dormitory, room: rooms[index]),
      ),
      childCount: rooms.length,
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item({required this.dormitory, required this.room});

  final DormitoryEntity dormitory;
  final RoomEntity room;

  void onTap(BuildContext context) => context.router.push(
    NamedRoute(
      'ExtraDataScreen',
      params: {'dormitory_id': dormitory.id, 'room_id': room.id},
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => onTap(context),
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        spacing: 24.0,
        children: [
          const Icon(Icons.room_outlined),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 4.0,
            children: [
              UiText2.m(room.number),
              UiText2.m(
                dormitory.name,
                color: Theme.of(context).colorPalette2.foregroundSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
