import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../home.dart';

class SpecializationsCarousel extends StatefulWidget {
  const SpecializationsCarousel({super.key});

  @override
  State<SpecializationsCarousel> createState() =>
      _SpecializationsCarouselState();
}

class _SpecializationsCarouselState extends State<SpecializationsCarousel> {
  final _controller = PageController(viewportFraction: 1.02);
  final _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightPageView = 160.0;
    return Padding(
      padding: AppInsets.screen,
      child: BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) => state.map(
          loading: (_) =>
              const Shimmer(child: SizedBox(width: .infinity, height: 176.0)),
          loaded: (state) => Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            spacing: 8.0,
            children: [
              SizedBox(
                height: heightPageView,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: state.specializations.length,
                  onPageChanged: (index) => _currentPage.value = index,
                  itemBuilder: (context, index) {
                    final spec = state.specializations[index];
                    return FractionallySizedBox(
                      widthFactor: 1 / _controller.viewportFraction,
                      child: _Item(spec: spec),
                    );
                  },
                ),
              ),
              Indicator(
                countPages: state.specializations.length,
                currentPage: _currentPage,
                controller: _controller,
              ),
            ],
          ),
          error: (state) => UiCard.standart(
            child: Center(child: UiText.bodyLarge(state.message)),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.spec});

  final SpecializationEntity spec;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              mainAxisSize: .max,
              spacing: 6.0,
              children: [
                UiText.titleLarge(spec.title),
                UiText.bodyLarge(spec.description),
              ],
            ),
          ),
          Image.asset(
            ImagesHelper.specializations + spec.photoUrl,
            height: 80.0,
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
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

  void _animateToPage(int index) => controller.animateToPage(
    index,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeIn,
  );
}
