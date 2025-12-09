import 'package:ui_kit/ui.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/widget/room_modal_sheet.dart';

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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }

  void _showRoomModalSheet(BuildContext context, DormitoryEntity dormitory) {
    showUiBottomSheet(
      context,
      RoomModalSheet(dormitory: dormitory),
      maxHeight: MediaQuery.of(context).size.height * 0.6,
    );
  }
}
