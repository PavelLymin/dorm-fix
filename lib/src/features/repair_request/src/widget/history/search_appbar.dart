import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppPadding.appBar(context: context);
    final spacing = 16.0;
    return SliverResizingHeader(
      minExtentPrototype: Padding(
        padding: padding,
        child: SizedBox(
          height:
              UiTextField.standard().style?.constraints?.maxWidth ??
              48.0 + spacing,
        ),
      ),
      maxExtentPrototype: _TitleAppBar(
        title: 'Заявки',
        padding: padding,
        spacing: spacing,
      ),
      child: BackdropGroup(
        child: ClipRRect(
          child: BackdropFilter.grouped(
            filter: .blur(sigmaX: .9, sigmaY: 4.0),
            child: _TitleAppBar(
              title: 'Заявки',
              padding: padding,
              spacing: spacing,
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleAppBar extends StatefulWidget {
  const _TitleAppBar({
    required this.title,
    required this.padding,
    required this.spacing,
  });

  final String title;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  State<_TitleAppBar> createState() => _TitleAppBarState();
}

class _TitleAppBarState extends State<_TitleAppBar> {
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
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: widget.spacing,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              spacing: 16.0,
              children: [
                UiButton.icon(
                  onPressed: () => context.router.pop(),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                UiText.headlineLarge(
                  widget.title,
                  overflow: .ellipsis,
                  style: TextStyle(
                    fontWeight: .w700,
                    color: palette.primaryForeground,
                  ),
                ),
              ],
            ),
          ),
          UiTextField.standard(
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
        ],
      ),
    );
  }
}
