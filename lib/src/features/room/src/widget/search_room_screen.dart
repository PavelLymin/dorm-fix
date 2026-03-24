import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';
import '../../room.dart';

class SearchRoomScreen extends StatefulWidget {
  const SearchRoomScreen({super.key, required this.dormitory});

  final DormitoryEntity dormitory;

  @override
  State<SearchRoomScreen> createState() => _SearchRoomScreenState();
}

class _SearchRoomScreenState extends State<SearchRoomScreen> {
  late final SearcRoomBloc _roomSearcBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _roomSearcBloc = SearcRoomBloc(
      dormitoryId: widget.dormitory.id,
      logger: dependency.logger,
      roomRepository: dependency.roomRepository,
    )..add(.fetch());
  }

  @override
  void dispose() {
    _roomSearcBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _roomSearcBloc,
    child: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _SearchInput()),
        BlocBuilder<SearcRoomBloc, SearchRoomState>(
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
                SearchRooms(dormitory: widget.dormitory, rooms: state.rooms),
            error: (state) =>
                SearchRooms(dormitory: widget.dormitory, rooms: state.rooms),
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
      onChanged: context.read<SearcRoomBloc>().onQueryChanged.add,
      style: .new(
        hintText: 'Поиск комнаты...',
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
