import 'package:ui_kit/ui.dart';

class CarouselIndicators extends StatelessWidget {
  const CarouselIndicators({
    super.key,
    required this.countPages,
    required this.currentPage,
    required this.controller,
  });

  final int countPages;
  final ValueNotifier<int> currentPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: .center,
          children: List.generate(
            countPages,
            (index) => GestureDetector(
              onTap: () => _animateToPage(index),
              child: Padding(
                padding: AppPadding.symmetric,
                child: SizedBox(
                  width: 8,
                  height: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: value == index
                          ? color.foreground
                          : color.mutedForeground,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _animateToPage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
