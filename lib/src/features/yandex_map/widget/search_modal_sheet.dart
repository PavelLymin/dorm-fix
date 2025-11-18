import 'package:dorm_fix/src/features/yandex_map/widget/suggest_tem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../state_management/bloc/search_bloc.dart';

class SearchModalSheet extends StatefulWidget {
  const SearchModalSheet({super.key});

  @override
  State<SearchModalSheet> createState() => _SearchModalSheetState();
}

class _SearchModalSheetState extends State<SearchModalSheet> {
  late final TextEditingController _searchController;
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchBloc = DependeciesScope.of(context).searchBloc;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
    _searchBloc.close();
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
                    error: (_) => Text('error'),
                    noTerm: (_) => Text('enter'),
                    searchPopulated: (state) {
                      final dormitories = state.dormitories;
                      return ListView.builder(
                        itemCount: dormitories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SuggestTem(dormitory: dormitories[index]);
                        },
                      );
                    },
                    searchEmpty: (_) => Text('empty'),
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
