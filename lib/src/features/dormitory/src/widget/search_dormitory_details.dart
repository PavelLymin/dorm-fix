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
        UiText2.lBold(dormitory.name),
        const SizedBox(height: 8.0),
        UiText2.m(dormitory.address, color: palette.foregroundSecondary),
        const SizedBox(height: 32.0),
        UiButton.filledPrimary(
          onPressed: () => showUiBottomSheet(
            context,
            title: 'Выбор комнаты',
            widget: SearchRoomScreen(dormitory: dormitory),
          ),
          label: UiText2.m('Выбрать'),
        ),
      ],
    );
  }
}
