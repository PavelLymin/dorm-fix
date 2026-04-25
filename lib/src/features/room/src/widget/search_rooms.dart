import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';
import '../../../dormitory/dormitory.dart';
import '../../room.dart';

class SearchRooms extends StatelessWidget {
  const SearchRooms({super.key, required this.dormitory, required this.rooms});

  final DormitoryEntity dormitory;
  final List<RoomEntity> rooms;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typography = theme.appTypography2;
    return SliverFixedExtentList(
      itemExtent: _Item.getExtent(typography),
      delegate: SliverChildBuilderDelegate(
        (_, index) => Padding(
          padding: AppInsets.item,
          child: _Item(dormitory: dormitory, room: rooms[index]),
        ),
        childCount: rooms.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.dormitory, required this.room});

  final DormitoryEntity dormitory;
  final RoomEntity room;

  static const _spacing = 4.0;

  void onTap(BuildContext context) => context.router.push(
    NamedRoute(
      'ExtraDataScreen',
      params: {'dormitory_id': dormitory.id, 'room_id': room.id},
    ),
  );

  static double getExtent(AppTypography2 typography) {
    final title = TextPainter(textDirection: .ltr, maxLines: 1)
      ..text = TextSpan(style: typography.m)
      ..layout();

    final subTitle = TextPainter(textDirection: .ltr, maxLines: 1)
      ..text = TextSpan(style: typography.lBold)
      ..layout();

    return title.height +
        subTitle.height +
        _spacing +
        AppInsets.card.vertical +
        AppInsets.item.vertical;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return UiCard.clickable(
      onTap: () => onTap(context),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: _spacing,
        children: [
          UiText2.lBold(room.number),
          UiText2.m(dormitory.name, color: palette.foregroundSecondary),
        ],
      ),
    );
  }
}
