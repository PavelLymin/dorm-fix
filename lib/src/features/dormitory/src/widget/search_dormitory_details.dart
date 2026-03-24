import 'package:ui_kit/ui.dart';
import '../../../room/room.dart';
import '../../dormitory.dart';

class SearchDormitoryDetails extends StatelessWidget {
  const SearchDormitoryDetails({super.key, required this.dormitory});

  final DormitoryEntity dormitory;

  @override
  Widget build(BuildContext context) {
    final palette = context.theme.colorPalette;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      children: [
        UiText.titleLarge(dormitory.name),
        const SizedBox(height: 8.0),
        UiText.titleMedium(dormitory.address, color: palette.mutedForeground),
        const SizedBox(height: 32.0),
        UiButton.filledPrimary(
          onPressed: () => showUiBottomSheet(
            context,
            title: 'Выбор комнаты',
            widget: SearchRoomScreen(dormitory: dormitory),
          ),
          label: UiText.titleMedium('Выбрать'),
        ),
      ],
    );
  }
}
