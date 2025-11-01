import 'dart:math' as math;
import 'package:ui_kit/ui.dart';
import 'package:dorm_fix/src/features/yandex_map/listeners/map_object_tap_listener.dart';
import 'package:dorm_fix/src/features/yandex_map/utils/extension_utils.dart';
import 'package:dorm_fix/src/features/yandex_map/data/geometry_provider.dart';
import 'package:dorm_fix/src/features/yandex_map/widget/yandex_map_kit.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit/image.dart' as image_provider;

class MapWithDormPins extends StatefulWidget {
  const MapWithDormPins({super.key, this.onMapDispose});
  final VoidCallback? onMapDispose;

  @override
  State<MapWithDormPins> createState() => _MapWithDormPins();
}

class _MapWithDormPins extends State<MapWithDormPins> {
  late final mapkit.MapObjectCollection _pinsCollection;

  late final _placemarkTapListener = MapObjectTapListenerImpl(
    onMapObjectTapped: (mapObject, _) {
      final placemarkPoint = mapObject
          .castOrNull<mapkit.PlacemarkMapObject>()
          ?.geometry;

      _showModalSheet(context, "Tapped the placemark:\n$placemarkPoint");
      return true;
    },
  );

  final _imageProvider = image_provider.ImageProvider.fromImageProvider(
    const AssetImage("packages/ui_kit/assets/icons/dorm_pin.png"),
  );

  mapkit.MapWindow? _mapWindow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [YandexMapKit(onMapCreated: _createMapObjects)]),
    );
  }

  void _createMapObjects(mapkit.MapWindow mapWindow) {
    _mapWindow = mapWindow;
    mapWindow.map.move(GeometryProvider.startPosition);
    _pinsCollection = mapWindow.map.mapObjects.addCollection();
    _addPlacemarkCollection(_pinsCollection);
  }

  void _addPlacemarkCollection(mapkit.MapObjectCollection pinsCollection) {
    for (var point in GeometryProvider.clusterizedPoints) {
      pinsCollection.addPlacemark()
        ..geometry = point
        ..setIcon(_imageProvider)
        ..setIconStyle(
          const mapkit.IconStyle(anchor: math.Point(0.5, 1.0), scale: 2.0),
        )
        ..addTapListener(_placemarkTapListener);
    }
  }

  void _showModalSheet(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return UiModalBottomSheet(text: text, child: Text(''));
      },
    );
  }
}
