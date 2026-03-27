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
        padding: context.appStyle.appPadding.vertical,
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
      'PersonalDataScreen',
      params: {'dormitory_id': dormitory.id, 'room_id': room.id},
    ),
  );

  @override
  Widget build(BuildContext context) {
    final palette = context.theme.colorPalette;
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
              UiText.bodyMedium(room.number),
              UiText.bodyMedium(dormitory.name, color: palette.mutedForeground),
            ],
          ),
        ],
      ),
    );
  }
}
