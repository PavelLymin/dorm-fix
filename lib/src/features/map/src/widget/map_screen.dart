import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';
import 'map_appbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with _MapScreenStateMixin {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _dormitoryBloc,
    child: Scaffold(
      body: Stack(
        children: [
          BlocBuilder<DormitoryBloc, DormitoryState>(
            builder: (context, state) => YandexMap(
              nightModeEnabled: true,
              mapObjects: _mapObjects(state.dormitories),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
          const MapAppbar(),
        ],
      ),
    ),
  );
}

mixin _MapScreenStateMixin on State<MapScreen> {
  late final DormitoryBloc _dormitoryBloc;
  late final YandexMapController _controller;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _dormitoryBloc = DormitoryBloc(
      dormitoryRepository: dependency.dormitoryRepository,
      logger: dependency.logger,
    )..add(.get());
  }

  @override
  void dispose() {
    _dormitoryBloc.close();
    _controller.dispose();
    super.dispose();
  }

  List<MapObject> _mapObjects(List<DormitoryEntity> dormitories) => dormitories
      .map(
        (dormitory) => PlacemarkMapObject(
          mapId: MapObjectId(dormitory.id.toString()),
          point: Point(latitude: dormitory.lat, longitude: dormitory.long),
          icon: .single(.new(image: .fromAssetImage(ImagesHelper.dormPin))),
        ),
      )
      .toList();
}
