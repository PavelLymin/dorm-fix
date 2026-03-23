import 'package:ui_kit/ui.dart';
import '../../../dormitory/dormitory.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.dormitories});

  final List<DormitoryEntity> dormitories;

  @override
  Widget build(BuildContext context) => SliverFixedExtentList(
    itemExtent: 48.0,
    delegate: SliverChildBuilderDelegate(
      (_, index) => _SearchItem(dormitory: dormitories[index]),
      childCount: dormitories.length,
    ),
  );
}

class LoadingSearchList extends StatelessWidget {
  const LoadingSearchList({super.key});

  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemCount: 5,
    itemBuilder: (_, _) =>
        const Shimmer(child: _SearchItem(dormitory: .fake())),
    separatorBuilder: (_, _) => const SizedBox(height: 8.0),
  );
}

class _SearchItem extends StatelessWidget {
  const _SearchItem({required this.dormitory});

  final DormitoryEntity dormitory;

  @override
  Widget build(BuildContext context) {
    final palette = context.theme.colorPalette;
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 24.0,
      children: [
        const Icon(Icons.apartment),
        Flexible(
          child: Column(
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
        ),
      ],
    );
  }
}
