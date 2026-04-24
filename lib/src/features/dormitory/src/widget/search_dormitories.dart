import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/map/map.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../dormitory.dart';

class SearchDormitories extends StatelessWidget {
  const SearchDormitories({super.key, required this.dormitories});

  final List<DormitoryEntity> dormitories;

  @override
  Widget build(BuildContext context) => SliverFixedExtentList(
    itemExtent: 48.0,
    delegate: SliverChildBuilderDelegate(
      (_, index) => Padding(
        padding: index == 0
            ? AppInsets.itemDense.copyWith(top: 0)
            : index == dormitories.length - 1
            ? AppInsets.itemDense.copyWith(bottom: 0)
            : AppInsets.item,
        child: _Item(dormitory: dormitories[index]),
      ),
      childCount: dormitories.length,
    ),
  );
}

class _Item extends StatelessWidget {
  const _Item({required this.dormitory});

  final DormitoryEntity dormitory;

  void _moveCameraToPoint(
    YandexMapController? controller, {
    double zoom = 17,
  }) async {
    final point = Point(latitude: dormitory.lat, longitude: dormitory.long);
    await controller?.moveCamera(
      .newCameraPosition(.new(target: point, zoom: zoom)),
      animation: const .new(type: .smooth, duration: 1.0),
    );
  }

  void _showDormitoryDetails(BuildContext context) {
    context.router.pop();
    _moveCameraToPoint(MapControllerScope.of(context));
    showUiBottomSheet(
      context,
      title: 'Общежитие',
      widget: SearchDormitoryDetails(dormitory: dormitory),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return GestureDetector(
      behavior: .opaque,
      onTap: () => _showDormitoryDetails(context),
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
              UiText2.m(dormitory.name),
              UiText2.m(dormitory.address, color: palette.foregroundSecondary),
            ],
          ),
        ],
      ),
    );
  }
}
