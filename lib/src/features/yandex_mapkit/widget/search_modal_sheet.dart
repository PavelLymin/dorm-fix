import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../state_management/search/search_bloc.dart';

class SearchModalSheet extends StatefulWidget {
  const SearchModalSheet({super.key, required this.onMoveCamera});
  final Future<void> Function(Point target, MapAnimation animation, double zoom)
  onMoveCamera;

  @override
  State<SearchModalSheet> createState() => _SearchModalSheetState();
}

class _SearchModalSheetState extends State<SearchModalSheet> {
  late final TextEditingController _searchController;
  late SearchBloc _searchBloc;

  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 1.0,
  );

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchBloc = DependeciesScope.of(context).searchBloc;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: UiModalBottomSheet(
        child: Column(
          children: [
            UiTextField.standard(
              controller: _searchController,
              style: UiTextFieldStyle(hintText: 'Text input'),
              onChanged: _searchBloc.onTextChanged.add,
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state.map(
                    loading: (_) => CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(
                        context,
                      ).colorPalette.primary.withValues(alpha: .38),
                    ),
                    error: (state) => Text(state.message),
                    noTerm: (_) => Text('Введите текст'),
                    searchPopulated: (state) {
                      final dormitories = state.dormitories;
                      return ListView.builder(
                        itemCount: dormitories.length,
                        itemBuilder: (context, index) {
                          final dormitory = dormitories[index];
                          return TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final point = Point(
                                latitude: dormitory.long,
                                longitude: dormitory.lat,
                              );
                              await widget.onMoveCamera(point, animation, 17);
                            },
                            child: Text(dormitories[index].name),
                          );
                        },
                      );
                    },
                    searchEmpty: (_) => Text('Такого общежития не существует'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
