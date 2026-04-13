import '../../ui.dart';

class UiCarousel extends StatefulWidget {
  const UiCarousel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.constraints,
    this.duration,
    this.curve,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final BoxConstraints constraints;
  final Duration? duration;
  final Curve? curve;

  @override
  State<UiCarousel> createState() => _UiCarouselState();
}

class _UiCarouselState extends State<UiCarousel> {
  late final PageController _controller;
  late final ValueNotifier<int> _currentPage;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1.0);
    _currentPage = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 8.0,
      children: [
        ConstrainedBox(
          constraints: widget.constraints,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.itemCount,
            onPageChanged: (index) => _currentPage.value = index,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        Indicator(
          countPages: widget.itemCount,
          currentPage: _currentPage,
          controller: _controller,
          duration: widget.duration,
          curve: widget.curve,
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.countPages,
    required this.currentPage,
    required this.controller,
    Duration? duration,
    Curve? curve,
  }) : _duration = duration ?? const Duration(milliseconds: 300),
       _curve = curve ?? Curves.easeIn;

  final int countPages;
  final ValueNotifier<int> currentPage;
  final PageController controller;
  final Duration _duration;
  final Curve _curve;

  void _animateToPage(int index) =>
      controller.animateToPage(index, duration: _duration, curve: _curve);

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette2;
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, _) => Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        spacing: 8.0,
        children: List.generate(
          countPages,
          (index) => GestureDetector(
            onTap: () => _animateToPage(index),
            child: SizedBox.square(
              dimension: 6.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: .circle,
                  color: value == index ? palette.primary : palette.disabled,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
