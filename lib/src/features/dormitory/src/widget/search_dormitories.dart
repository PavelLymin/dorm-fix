import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/map/map.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../dormitory.dart';

class SearchDormitories extends StatelessWidget {
  const SearchDormitories({super.key, required this.dormitories});

  final List<DormitoryEntity> dormitories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typography = theme.appTypography2;
    return SliverPadding(
      padding: .only(top: 8.0),
      sliver: SliverFixedExtentList(
        itemExtent: _Item.getExtent(typography),
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: AppInsets.item,
            child: _Item(dormitory: dormitories[index]),
          ),
          childCount: dormitories.length,
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.dormitory});

  final DormitoryEntity dormitory;

  static const _spacing = 4.0;

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
      spacing: 0.0,
      title: AppLocalizations.of(context).dormitory,
      widget: SearchDormitoryDetails(dormitory: dormitory),
    );
  }

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
      onTap: () => _showDormitoryDetails(context),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: _spacing,
        children: [
          UiText2.lBold(dormitory.name),
          UiText2.m(dormitory.address, color: palette.foregroundSecondary),
        ],
      ),
    );
  }
}
