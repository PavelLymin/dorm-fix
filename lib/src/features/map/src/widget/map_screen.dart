import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';

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
              nightModeEnabled: false,
              mapObjects: _mapObjects(state.dormitories),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
          const MapAppbar(),
          const SearchButton(),
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
          onTap: (_, point) => _showDormitoryDetails(context, point, dormitory),
        ),
      )
      .toList();

  void _moveCameraToPoint(Point target, {double zoom = 17}) async =>
      await _controller.moveCamera(
        .newCameraPosition(.new(target: target, zoom: zoom)),
        animation: const .new(type: .smooth, duration: 1.0),
      );

  void _showDormitoryDetails(
    BuildContext context,
    Point point,
    DormitoryEntity dormitory,
  ) {
    _moveCameraToPoint(point);
    showUiBottomSheet(
      context,
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
        padding: context.appStyle.appPadding.contentPadding,
        child: UiText.displayLarge(
          'Найдите свое общежитие',
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
    return Align(
      alignment: .bottomCenter,
      child: UiCard.standart(
        padding: context.appStyle.appPadding.verticalIncrement(increment: 3),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: context.appStyle.appPadding.pagePadding,
            child: GestureDetector(
              onTap: () => showUiBottomSheet(
                context,
                title: 'Выбор общежития',
                widget: const SearchDormitoryScreen(),
              ),
              child: UiTextField.standard(
                enabled: false,
                style: .new(
                  hintText: 'Поиск общежитий...',
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
