import 'package:ui_kit/ui.dart';
import '../../dormitory.dart';

class SearchDormitories extends StatelessWidget {
  const SearchDormitories({super.key, required this.dormitories});

  final List<DormitoryEntity> dormitories;

  @override
  Widget build(BuildContext context) => SliverFixedExtentList(
    itemExtent: 48.0,
    delegate: SliverChildBuilderDelegate(
      (_, index) => Padding(
        padding: context.appStyle.appPadding.vertical,
        child: _Item(dormitory: dormitories[index]),
      ),
      childCount: dormitories.length,
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item({required this.dormitory});

  final DormitoryEntity dormitory;

  @override
  Widget build(BuildContext context) {
    final palette = context.theme.colorPalette;
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        spacing: 24.0,
        children: [
          const Icon(Icons.apartment),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 4.0,
            children: [
              UiText.bodyMedium(dormitory.name),
              UiText.bodyMedium(
                dormitory.address,
                color: palette.mutedForeground,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
