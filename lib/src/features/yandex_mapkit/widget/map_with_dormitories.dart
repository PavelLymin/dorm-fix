import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../state_management/pins/bloc/pins_bloc.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../model/dormitory.dart';
import 'search_modal_sheet.dart';
import 'yandex_mapkit.dart';

class MapWithDormitories extends StatefulWidget {
  const MapWithDormitories({super.key});

  @override
  State<MapWithDormitories> createState() => _MapWithDormitoriesState();
}

class _MapWithDormitoriesState extends State<MapWithDormitories> {
  YandexMapController? _mapController;
  late PinsBloc _pinsBloc;
  List<MapObject> _mapObjects = [];

  @override
  void initState() {
    super.initState();
    _pinsBloc = DependeciesScope.of(context).pinsBloc;
    _pinsBloc.add(PinsEvent.get());
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _pinsBloc,
    child: BlocBuilder<PinsBloc, PinsState>(
      builder: (context, state) => state.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        loaded: (state) {
          _mapObjects = _createMapObjects(state.dormitories);

          return Scaffold(
            body: Stack(
              children: [
                YandexMapkit(
                  onMapCreated: _onMapCreated,
                  mapObjects: _mapObjects,
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () => _showSearchModalSheet(context),
                        child: const Text('Search'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (state) => Text(state.message),
      ),
    ),
  );

  Future<void> _onMapCreated(YandexMapController controller) async {
    _mapController = controller;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            target: Point(latitude: 56.010543, longitude: 92.852581),
            zoom: 14,
          ),
        ),
      );
    });
  }

  List<MapObject> _createMapObjects(List<DormitoryEntity> dormitories) {
    return dormitories
        .map(
          (dorm) => PlacemarkMapObject(
            mapId: MapObjectId(dorm.id.toString()),
            point: Point(latitude: dorm.lat, longitude: dorm.long),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(ImagesHelper.dormPin),
              ),
            ),
          ),
        )
        .toList();
  }

  Future<void> _onMoveCamera(
    Point target,
    MapAnimation animation,
    double zoom,
  ) async {
    final controller = _mapController;
    final update = CameraUpdate.newCameraPosition(
      CameraPosition(target: target, zoom: zoom),
    );

    await controller?.moveCamera(update, animation: animation);
  }

  void _showSearchModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SearchModalSheet(onMoveCamera: _onMoveCamera);
      },
    );
  }
}
