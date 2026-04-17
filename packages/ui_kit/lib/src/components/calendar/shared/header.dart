import 'package:ui_kit/ui.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.onPrevious, this.onNext});

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      padding: .all(20.0),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          UiButton.icon(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left_outlined),
          ),
          const Spacer(),
          UiButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right_outlined),
          ),
        ],
      ),
    );
  }
}

class PagedPicker extends StatefulWidget {
  const PagedPicker({
    super.key,
    required this.start,
    required this.end,
    required this.today,
    required this.initial,
  });

  final DateTime start;
  final DateTime end;
  final DateTime today;
  final DateTime initial;
  final Duration pageAnimationDuration = const Duration(milliseconds: 200);

  @override
  State<PagedPicker> createState() => _PagedPickerState();
}

class _PagedPickerState extends State<PagedPicker> {
  late final PageController _controller;

  bool get _first => widget.start.difference(widget.initial).inDays == 0;
  bool get _last => widget.end.difference(widget.initial).inDays == 0;

  void _onNext() {
    if (!_last) {
      _controller.nextPage(
        duration: widget.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  void _onPrevious() {
    if (!_first) {
      _controller.previousPage(
        duration: widget.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  void _showPage(DateTime date) {
    final page = date.difference(widget.start).inDays;
    _controller.animateToPage(
      page,
      duration: widget.pageAnimationDuration,
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: widget.initial.difference(widget.start).inDays,
    );
  }

  @override
  void didUpdateWidget(covariant PagedPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != oldWidget.start || widget.end != oldWidget.end) {
      _controller.dispose();
      _controller = PageController(
        initialPage: widget.initial.difference(widget.start).inDays,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildItem(BuildContext context, int page) {
    // final date = widget.start.add(Duration(days: page));
    // return DateItem(date: date, today: widget.today, onSelect: _showPage);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          onPrevious: _first ? null : _onPrevious,
          onNext: _last ? null : _onNext,
        ),
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemBuilder: buildItem,
            itemCount: widget.start.difference(widget.end).inDays + 1,
          ),
        ),
      ],
    );
  }
}
