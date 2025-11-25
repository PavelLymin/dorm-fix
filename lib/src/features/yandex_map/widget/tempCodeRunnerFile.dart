// import 'dart:math' as math;

// import 'package:dorm_fix/src/features/yandex_map/widget/search_modal_sheet.dart';
// import 'package:ui_kit/ui.dart';
// import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;
// import 'package:yandex_maps_mapkit/image.dart' as image_provider;

// import '../data/geometry_provider.dart';
// import '../listeners/map_object_tap_listener.dart';
// import '../utils/extension_utils.dart';
// import 'yandex_map_kit.dart';

// class MapWithDormPins extends StatefulWidget {
//   const MapWithDormPins({super.key, this.onMapDispose});
//   final VoidCallback? onMapDispose;

//   @override
//   State<MapWithDormPins> createState() => _MapWithDormPins();
// }

// class _MapWithDormPins extends State<MapWithDormPins> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   late final mapkit.MapObjectCollection _pinsCollection;

//   late final _placemarkTapListener = MapObjectTapListenerImpl(
//     onMapObjectTapped: (mapObject, _) {
//       final placemarkPoint = mapObject
//           .castOrNull<mapkit.PlacemarkMapObject>()
//           ?.geometry;

//       _showModalSheet(context, "Tapped the placemark:\n$placemarkPoint");
//       return true;
//     },
//   );

//   final _imageProvider = image_provider.ImageProvider.fromImageProvider(
//     const AssetImage("packages/ui_kit/assets/icons/dorm_pin.png"),
//   );

//   mapkit.MapWindow? _mapWindow;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           YandexMapKit(onMapCreated: _createMapObjects),
//           Positioned(
//             bottom: 0.0,
//             right: 0.0,
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () => _showSearchModalSheet(context),
//                   child: const Text('Search'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _createMapObjects(mapkit.MapWindow mapWindow) {
//     _mapWindow = mapWindow;
//     _mapWindow!.map.move(GeometryProvider.startPosition);
//     _pinsCollection = _mapWindow!.map.mapObjects.addCollection();
//     _addPlacemarkCollection(_pinsCollection);
//   }

//   void _addPlacemarkCollection(mapkit.MapObjectCollection pinsCollection) {
//     for (var point in GeometryProvider.clusterizedPoints) {
//       pinsCollection.addPlacemark()
//         ..geometry = point
//         ..setIcon(_imageProvider)
//         ..setIconStyle(
//           const mapkit.IconStyle(anchor: math.Point(0.5, 1.0), scale: 2.0),
//         )
//         ..addTapListener(_placemarkTapListener);
//     }
//   }

//   void _showModalSheet(BuildContext context, String text) {
//     showModalBottomSheet(
//       context: context,
//       builder: (builder) {
//         return UiModalBottomSheet(child: Text(''));
//       },
//     );
//   }

//   void _showSearchModalSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (builder) {
//         return const SearchModalSheet();
//       },
//     );
//   }
// }
