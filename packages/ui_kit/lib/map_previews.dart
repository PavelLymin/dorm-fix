import 'dart:math' as math;
import 'package:ui_kit/ui.dart';
import 'package:ui_kit/src/components/yandex_map/listeners/map_object_tap_listener.dart';
import 'package:ui_kit/src/components/yandex_map/utils/extension_utils.dart';
import 'package:ui_kit/src/components/yandex_map/utils/snackbar.dart';
import 'package:ui_kit/src/components/yandex_map/data/geometry_provider.dart';
import 'package:ui_kit/src/components/yandex_map/map/yandex_map_kit.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit/image.dart' as image_provider;

class MapPreviews extends StatefulWidget {
  const MapPreviews({super.key, this.onMapDispose});
  final VoidCallback? onMapDispose;

  @override
  State<MapPreviews> createState() => _MapPreviewsState();
}

class _MapPreviewsState extends State<MapPreviews> {
  late final mapkit.MapObjectCollection _pinsCollection;

  late final _placemarkTapListener = MapObjectTapListenerImpl(
    onMapObjectTapped: (mapObject, _) {
      final placemarkPoint = mapObject
          .castOrNull<mapkit.PlacemarkMapObject>()
          ?.geometry;

      showSnackBar(context, "Tapped the placemark:\n$placemarkPoint");
      return true;
    },
  );

  final _imageProvider = image_provider.ImageProvider.fromImageProvider(
    const AssetImage("assets/dorm_pin.png"),
  );

  mapkit.MapWindow? _mapWindow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: YandexMapKit(onMapCreated: _createMapObjects));
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
}
