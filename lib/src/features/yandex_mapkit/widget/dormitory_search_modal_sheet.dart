import 'package:dorm_fix/src/features/yandex_mapkit/model/dormitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../state_management/dormitory_search_bloc/dormitory_search_bloc.dart';

class DormitorySearchModalSheet extends StatefulWidget {
  const DormitorySearchModalSheet({super.key});

  @override
  State<DormitorySearchModalSheet> createState() =>
      _DormitorySearchModalSheetState();
}

class _DormitorySearchModalSheetState extends State<DormitorySearchModalSheet> {
  late final TextEditingController _searchController;
  late DormitorySearchBloc _dormitorySearchBloc;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _dormitorySearchBloc = DependeciesScope.of(context).dormitorySearchBloc;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dormitorySearchBloc,
      child: Column(
        children: [
          SizedBox(height: 16),
          UiTextField.standard(
            controller: _searchController,
            style: UiTextFieldStyle(hintText: 'Text input'),
            onChanged: _dormitorySearchBloc.onTextChanged.add,
          ),
          Expanded(
            child: BlocBuilder<DormitorySearchBloc, DormitorySearchState>(
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
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pop<DormitoryEntity>(dormitory);
                          },
                          child: Text(dormitory.name),
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
    );
  }
}
