import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';

class SearchDormitoryScreen extends StatefulWidget {
  const SearchDormitoryScreen({super.key});

  @override
  State<SearchDormitoryScreen> createState() => _SearchDormitoryScreenState();
}

class _SearchDormitoryScreenState extends State<SearchDormitoryScreen> {
  late final SearchDormitoryBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _searchBloc = SearchDormitoryBloc(
      dormitoryRepository: dependency.dormitoryRepository,
      logger: dependency.logger,
    )..add(.fetch());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _searchBloc,
    child: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _SearchInput()),
        BlocBuilder<SearchDormitoryBloc, SearchDormitoryState>(
          builder: (context, state) => state.map(
            loading: (_) => SliverToBoxAdapter(
              child: Center(
                child: SizedBox.square(
                  dimension: 32.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorPalette.mutedForeground,
                  ),
                ),
              ),
            ),
            loaded: (state) =>
                SearchDormitories(dormitories: state.dormitories),
            error: (state) => SearchDormitories(dormitories: state.dormitories),
          ),
        ),
      ],
    ),
  );
}

class _SearchInput extends StatefulWidget {
  const _SearchInput();

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.appStyle.appPadding.onlyIncrement(bottom: 2),
    child: UiTextField.standard(
      controller: _controller,
      onChanged: context.read<SearchDormitoryBloc>().onQueryChanged.add,
      style: .new(
        hintText: 'Поиск общежитий...',
        prefixIcon: const Icon(Icons.search_outlined),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() => _controller.clear());
                },
              ),
      ),
    ),
  );
}
