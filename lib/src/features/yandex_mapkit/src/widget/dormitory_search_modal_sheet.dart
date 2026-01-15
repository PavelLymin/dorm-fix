import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../yandex_mapkit.dart';

class DormitorySearchModalSheet extends StatefulWidget {
  const DormitorySearchModalSheet({super.key});

  @override
  State<DormitorySearchModalSheet> createState() =>
      _DormitorySearchModalSheetState();
}

class _DormitorySearchModalSheetState extends State<DormitorySearchModalSheet> {
  late final TextEditingController _searchController;
  late final DormitorySearchBloc _dormitorySearchBloc;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // _dormitorySearchBloc = DependeciesScope.of(context).dormitorySearchBloc;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dormitorySearchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return BlocProvider.value(
      value: _dormitorySearchBloc,
      child: Padding(
        padding: AppPadding.symmetricIncrement(horizontal: 2),
        child: Column(
          children: [
            const SizedBox(height: 16),
            UiTextField.standard(
              controller: _searchController,
              style: UiTextFieldStyle(
                hintText: 'Поиск общежитий...',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: _dormitorySearchBloc.onTextChanged.add,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: BlocBuilder<DormitorySearchBloc, DormitorySearchState>(
                builder: (context, state) {
                  return state.map(
                    loading: (_) => CircularProgressIndicator(
                      strokeWidth: 2,
                      color: color.primary.withValues(alpha: .38),
                    ),
                    error: (state) => UiText.bodyMedium(state.message),
                    noTerm: (_) => UiText.bodyMedium('Введите текст в поле'),
                    searchPopulated: (state) {
                      final dormitories = state.dormitories;
                      return GroupedList(
                        divider: .full(),
                        items: [
                          for (var dormitory in dormitories)
                            GroupedListItem(
                              title: dormitory.name,
                              data: dormitory.address,
                              onTap: () => Navigator.pop(context, dormitory),
                            ),
                        ],
                      );
                    },
                    searchEmpty: (_) =>
                        const Text('Такого общежития не существует'),
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
