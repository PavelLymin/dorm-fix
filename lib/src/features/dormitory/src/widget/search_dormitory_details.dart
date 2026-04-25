import 'package:ui_kit/ui.dart';
import '../../../room/room.dart';
import '../../dormitory.dart';

class SearchDormitoryDetails extends StatelessWidget {
  const SearchDormitoryDetails({super.key, required this.dormitory});

  final DormitoryEntity dormitory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      children: [
        Padding(
          padding: const .only(top: 24.0, bottom: 20.0),
          child: UiCard.standart(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 4.0,
              children: [
                UiText2.lBold(dormitory.name),
                UiText2.m(
                  dormitory.address,
                  color: palette.foregroundSecondary,
                ),
              ],
            ),
          ),
        ),
        UiButton.filledPrimary(
          onPressed: () => showUiBottomSheet(
            context,
            spacing: 0.0,
            title: 'Выбор комнаты',
            widget: SearchRoomScreen(dormitory: dormitory),
          ),
          label: Text('Выбрать'),
        ),
      ],
    );
  }
}
