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
  Widget build(BuildContext context) =>
      BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) {
          return Column(
            spacing: 8,
            children: [
              SizedBox(
                height: 160,
                child: state.map(
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (state) => PageView.builder(
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
                  error: (state) => UiCard.standart(
                    child: Center(
                      child: UiText.bodyLarge(state.message, softWrap: false),
                    ),
                  ),
                ),
              ),
              Indicator(
                countPages: state.specializations.length,
                currentPage: _currentPage,
                controller: _controller,
              ),
            ],
          );
        },
      );
}

class _Item extends StatelessWidget {
  const _Item({required this.spec});

  final SpecializationEntity spec;

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(context).appGradient;

    return UiCard.standart(
      padding: AppPadding.symmetricIncrement(horizontal: 2, vertical: 3),
      gradient: gradient.primary,
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              mainAxisSize: .max,
              children: [
                UiText.titleLarge(spec.title),
                const SizedBox(height: 16.0),
                UiText.bodyLarge(spec.description),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(ImagesHelper.specializations + spec.photoUrl, height: 84),
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
    final palette = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: 8.0,
          children: List.generate(
            countPages,
            (index) => GestureDetector(
              onTap: () => _animateToPage(index),
              child: SizedBox.square(
                dimension: 8.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: value == index
                        ? palette.foreground
                        : palette.borderStrong,
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
