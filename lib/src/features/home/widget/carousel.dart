import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../model/specialization.dart';
import '../state_management/bloc/specialization_bloc.dart';
import 'carousel_indecator.dart';

class SpecializationsCarousel extends StatefulWidget {
  const SpecializationsCarousel({super.key});

  @override
  State<SpecializationsCarousel> createState() =>
      _SpecializationsCarouselState();
}

class _SpecializationsCarouselState extends State<SpecializationsCarousel> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

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
                height: 164,
                child: state.map(
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (state) => PageView.builder(
                    controller: _controller,
                    itemCount: state.specializations.length,
                    onPageChanged: (index) => _currentPage.value = index,
                    itemBuilder: (context, index) {
                      final spec = state.specializations[index];
                      return _CarouselWrapper(child: _CarouselItem(spec: spec));
                    },
                  ),
                  error: (state) => UiCard.standart(
                    child: Center(
                      child: UiText.bodyLarge(state.message, softWrap: false),
                    ),
                  ),
                ),
              ),
              CarouselIndicators(
                countPages: state.specializations.length,
                currentPage: _currentPage,
                controller: _controller,
              ),
            ],
          );
        },
      );
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.spec});

  final SpecializationEntity spec;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiText.titleLarge(spec.title),
            const SizedBox(height: 16),
            UiText.bodyLarge(spec.description),
          ],
        ),
      ),
      const Spacer(),
      Image.asset(ImagesHelper.specializations + spec.photoUrl, height: 84),
    ],
  );
}

class _CarouselWrapper extends StatelessWidget {
  const _CarouselWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(2.0),
    child: UiCard.standart(
      padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 3),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF50ACF9), Color(0xFF0064B7)],
      ),
      child: child,
    ),
  );
}
