import 'package:dorm_fix/src/features/yandex_mapkit/widget/map_title.dart';
import 'package:dorm_fix/src/features/yandex_mapkit/widget/search_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../state_management/pins_bloc/pins_bloc.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../model/dormitory.dart';
import 'dormitory_details_modal_sheet.dart';
import 'dormitory_search_modal_sheet.dart';
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
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                YandexMapkit(
                  onMapCreated: _onMapCreated,
                  mapObjects: _mapObjects,
                ),
                MapTitle(),
                SearchButton(onTap: () => _showSearchModalSheet(context)),
              ],
            ),
          );
        },
        error: (state) => Text(state.message),
      ),
    ),
  );

  void _onMapCreated(YandexMapController controller) {
    _mapController = controller;
    _mapController?.moveCamera(
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
          (dormitory) => PlacemarkMapObject(
            mapId: MapObjectId(dormitory.id.toString()),
            point: Point(latitude: dormitory.lat, longitude: dormitory.long),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(ImagesHelper.dormPin),
              ),
            ),
            onTap: (PlacemarkMapObject self, Point point) =>
                _showDormitoryDetailsModalSheet(context, dormitory),
          ),
        )
        .toList();
  }

  void _onMoveCameraToPoint(Point target, {double zoom = 17}) async {
    await _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 1.0,
      ),
    );
  }

  void _showDormitoryDetailsModalSheet(
    BuildContext context,
    DormitoryEntity dormitory,
  ) {
    _onMoveCameraToPoint(
      Point(longitude: dormitory.long, latitude: dormitory.lat),
    );
    showUiBottomSheet(
      context,
      DormitoryDetailsModalSheet(dormitory: dormitory),
      maxHeight: MediaQuery.of(context).size.height * 0.3,
    );
  }

  Future<void> _showSearchModalSheet(BuildContext context) async {
    await showUiBottomSheet<DormitoryEntity?>(
      context,
      const DormitorySearchModalSheet(),
      maxHeight: MediaQuery.of(context).size.height * 0.6,
    ).then((selectedDormitory) {
      if (selectedDormitory != null && context.mounted) {
        _showDormitoryDetailsModalSheet(context, selectedDormitory);
      }
    });
  }
}
