import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapkit extends StatelessWidget {
  const YandexMapkit({
    super.key,
    required List<MapObject<dynamic>> mapObjects,
    required Function(YandexMapController)? onMapCreated,
  }) : _mapObjects = mapObjects,
       _onMapCreated = onMapCreated;
  final List<MapObject<dynamic>> _mapObjects;
  final Function(YandexMapController)? _onMapCreated;

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      nightModeEnabled: true,
      onMapCreated: _onMapCreated,
      mapObjects: _mapObjects,
    );
  }
}
