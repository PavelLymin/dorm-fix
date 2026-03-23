import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../state_management/bloc/search_bloc.dart';
import 'search_list.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({super.key});

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _searchBloc = SearchBloc(
      dormitoryRepository: dependency.dormitoryRepository,
      logger: dependency.logger,
    );
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
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) => state.map(
            loading: (_) => const LoadingSearchList(),
            loaded: (state) => SearchList(dormitories: state.dormitories),
            error: (state) => SearchList(dormitories: state.dormitories),
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
  Widget build(BuildContext context) => UiTextField.standard(
    controller: _controller,
    onChanged: context.read<SearchBloc>().onQueryChanged.add,
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
  );
}
