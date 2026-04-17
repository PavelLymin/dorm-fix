import 'package:ui_kit/ui.dart';

class HistorySearch extends StatefulWidget {
  const HistorySearch({super.key});

  @override
  State<HistorySearch> createState() => _HistorySearchState();
}

class _HistorySearchState extends State<HistorySearch> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _clearText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (_controller.text.isNotEmpty && !_clearText) {
      setState(() => _clearText = true);
    } else if (_controller.text.isEmpty && _clearText) {
      setState(() => _clearText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: .only(top: 16.0),
      sliver: SliverToBoxAdapter(
        child: UiTextField.standard(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: .text,
          textInputAction: .search,
          style: UiTextFieldStyle(
            hintText: 'Поиск заявки',
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _focusNode.unfocus();
                      setState(() => _controller.clear());
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
