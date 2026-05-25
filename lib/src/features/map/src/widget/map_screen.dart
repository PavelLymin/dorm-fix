import 'package:dorm_fix/l10n/gen/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';
import '../../map.dart';

class MapControllerScope extends InheritedWidget {
  const MapControllerScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final YandexMapController? controller;

  static YandexMapController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<MapControllerScope>()
      ?.controller;

  @override
  bool updateShouldNotify(covariant MapControllerScope oldWidget) =>
      controller != oldWidget.controller;
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with _MapScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: _dormitoryBloc,
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<DormitoryBloc, DormitoryState>(
              builder: (context, state) =>
                  FutureBuilder<List<PlacemarkMapObject>>(
                    future: _mapObjects(state.dormitories, theme),
                    builder: (context, snapshot) => YandexMap(
                      nightModeEnabled: false,
                      mapObjects: [
                        _getClusterizedCollection(
                          theme: theme,
                          placemarks: snapshot.data ?? const [],
                        ),
                      ],
                      onMapCreated: _onMapCreated,
                      onCameraPositionChanged: (cameraPosition, _, _) =>
                          _mapZoom = cameraPosition.zoom,
                    ),
                  ),
            ),
            ValueListenableBuilder(
              valueListenable: _controllerNotifier,
              builder: (_, value, _) =>
                  MapControllerScope(controller: value, child: SearchButton()),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _MapScreenStateMixin on State<MapScreen> {
  late final DormitoryBloc _dormitoryBloc;
  late final ValueNotifier<YandexMapController?> _controllerNotifier;
  YandexMapController? _controller;
  double _mapZoom = 0.0;

  @override
  void initState() {
    super.initState();
    _controllerNotifier = ValueNotifier(null);
    final dependency = DependeciesScope.of(context);
    _dormitoryBloc = DormitoryBloc(
      dormitoryRepository: dependency.dormitoryRepository,
      logger: dependency.logger,
    )..add(.get());
  }

  @override
  void dispose() {
    _dormitoryBloc.close();
    _controller?.dispose();
    super.dispose();
  }

  void _onMapCreated(YandexMapController controller) {
    _controller = controller;
    _controllerNotifier.value = _controller;
    final position = const Position();
    _controller?.moveCamera(
      animation: const MapAnimation(type: .linear, duration: 0.3),
      .newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
          zoom: position.zoom,
        ),
      ),
    );
  }

  Future<List<PlacemarkMapObject>> _mapObjects(
    List<DormitoryEntity> dormitories,
    ThemeData theme,
  ) => Future.wait(
    dormitories.map(
      (dormitory) async => PlacemarkMapObject(
        mapId: MapObjectId(dormitory.id.toString()),
        point: Point(latitude: dormitory.lat, longitude: dormitory.long),
        icon: .single(
          PlacemarkIconStyle(
            image: .fromBytes(
              await PinIconPainter(
                dormitory.number.toString(),
              ).getClusterIconBytes(theme: theme),
            ),
          ),
        ),
        onTap: (_, point) => _showDormitoryDetails(context, point, dormitory),
      ),
    ),
  );

  void _moveCameraToPoint(Point target, {double zoom = 17}) async =>
      await _controller?.moveCamera(
        .newCameraPosition(.new(target: target, zoom: zoom)),
        animation: const .new(type: .smooth, duration: 1.0),
      );

  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required ThemeData theme,
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: placemarks,
      radius: 50,
      minZoom: 15,
      onClusterAdded: (self, cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1.0,
            icon: .single(
              PlacemarkIconStyle(
                image: .fromBytes(
                  await ClusterIconPainter(
                    cluster.size,
                  ).getClusterIconBytes(theme: theme),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        await _controller?.moveCamera(
          animation: const MapAnimation(type: .linear, duration: 0.3),
          .newCameraPosition(
            CameraPosition(
              target: cluster.placemarks.first.point,
              zoom: _mapZoom + 1,
            ),
          ),
        );
      },
    );
  }

  void _showDormitoryDetails(
    BuildContext context,
    Point point,
    DormitoryEntity dormitory,
  ) {
    _moveCameraToPoint(point);
    showUiBottomSheet(
      context,
      spacing: 0.0,
      title: 'Общежитие',
      widget: SearchDormitoryDetails(dormitory: dormitory),
    );
  }
}

class MapAppbar extends StatelessWidget {
  const MapAppbar({super.key});

  @override
  Widget build(BuildContext context) => Align(
    alignment: .topStart,
    child: SafeArea(
      child: Padding(
        padding: AppInsets.screen,
        child: UiText2.lBold(
          AppLocalizations.of(context).select_dormitory,
          softWrap: true,
          textAlign: .left,
        ),
      ),
    ),
  );
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Align(
      alignment: .bottomCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.card,
          borderRadius: .horizontal(
            left: .circular(24.0),
            right: .circular(24.0),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: AppInsets.screen.copyWith(top: 20.0),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 24.0,
              children: [
                UiText2.lBold(AppLocalizations.of(context).dormitory_selection),
                GestureDetector(
                  onTap: () => showUiBottomSheet(
                    context,
                    spacing: 0.0,
                    title: AppLocalizations.of(context).dormitory_selection,
                    widget: MapControllerScope(
                      controller: MapControllerScope.of(context),
                      child: SearchDormitoryScreen(),
                    ),
                  ),
                  child: UiTextField.search(
                    enabled: false,
                    style: .new(hintText: AppLocalizations.of(context).search),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
