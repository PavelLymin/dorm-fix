import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../specialization.dart';

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
    return BlocBuilder<SpecializationBloc, SpecializationState>(
      builder: (context, state) => state.map(
        loading: (_) =>
            const Shimmer(child: SizedBox(width: .infinity, height: 110.0)),
        loaded: (state) => UiCarousel(
          constraints: const BoxConstraints(maxHeight: 110.0),
          itemCount: state.specializations.length,
          itemBuilder: (context, index) {
            final spec = state.specializations[index];
            return _Item(spec: spec);
          },
        ),
        error: (state) =>
            UiCard.standart(child: Center(child: UiText2.lBold(state.message))),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.spec});

  final SpecializationEntity spec;

  @override
  Widget build(BuildContext context) {
    return UiCard.clickable(
      onTap: () => showUiBottomSheet(
        context,
        title: spec.title,
        widget: SpecializationScreen(specialization: spec),
      ),
      padding: .only(left: 20.0, top: 12.0, right: 20.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        spacing: 12.0,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              mainAxisSize: .max,
              spacing: 6.0,
              children: [
                UiText2.lBold(spec.title),
                UiText2.m(
                  spec.description,
                  maxLines: 2,
                  color: Theme.of(context).colorPalette2.foregroundSecondary,
                  overflow: .ellipsis,
                ),
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
