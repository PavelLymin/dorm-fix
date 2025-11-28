import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/state_management/pins/bloc/pins_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../app/widget/dependencies_scope.dart';
import 'search_modal_sheet.dart';

class MapWithDormitories extends StatefulWidget {
  const MapWithDormitories({super.key});

  @override
  State<MapWithDormitories> createState() => _MapWithDormitoriesState();
}

class _MapWithDormitoriesState extends State<MapWithDormitories> {
  late final YandexMapController _mapController;
  late PinsBloc _pinsBloc;
  List<MapObject> mapObjects = [];

  @override
  void initState() {
    super.initState();
    _pinsBloc = DependeciesScope.of(context).pinsBloc;
    _pinsBloc.add(PinsEvent.get());
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _pinsBloc,
    child: BlocConsumer<PinsBloc, PinsState>(
      listener: (context, state) {
        state.mapOrNull(
          loaded: (state) {
            mapObjects = _createMapObjects(state.dormitories);
          },
        );
      },
      builder: (context, state) => state.maybeMap(
        orElse: () => Scaffold(
          body: Stack(
            children: [
              YandexMap(onMapCreated: _createMap, mapObjects: mapObjects),
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
        ),
        loading: (_) => const Center(child: CircularProgressIndicator()),
      ),
    ),
  );

  Future<void> _createMap(YandexMapController controller) async {
    _mapController = controller;

    await _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: Point(latitude: 56.010543, longitude: 92.852581),
          zoom: 14,
        ),
      ),
    );
  }

  List<MapObject> _createMapObjects(List<DormitoryEntity> dormitories) {
    return dormitories
        .map(
          (dorm) => PlacemarkMapObject(
            mapId: MapObjectId(dorm.id.toString()),
            point: Point(latitude: dorm.lat, longitude: dorm.long),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'packages/ui_kit/assets/icons/dorm_pin.png',
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  void _showSearchModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return const SearchModalSheet();
      },
    );
  }
}
