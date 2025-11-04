import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../model/specialization.dart';
import '../state_management/bloc/specialization_bloc.dart';

class SpecializationsCarousel extends StatefulWidget {
  const SpecializationsCarousel({super.key});

  @override
  State<SpecializationsCarousel> createState() =>
      _SpecializationsCarouselState();
}

class _SpecializationsCarouselState extends State<SpecializationsCarousel> {
  final ValueNotifier<int> _index = ValueNotifier(0);
  final CarouselController _controller = CarouselController();
  late SpecializationBloc _specializationBloc;
  late double _itemWeight;

  @override
  void initState() {
    super.initState();
    _specializationBloc = DependeciesScope.of(context).specializationBloc;
    _specializationBloc.add(SpecializationEvent.getSpecializations());
    _controller.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemWeight = WindowSizeScope.of(context).width - 32;
  }

  void _onFocusChanged() {
    int index = (_controller.offset / _itemWeight).round();
    if (_index.value != index) {
      _index.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _specializationBloc,
      child: BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 182,
                child: CarouselView(
                  enableSplash: false,
                  padding: const EdgeInsets.all(0),
                  itemExtent: _itemWeight,
                  itemSnapping: true,
                  controller: _controller,
                  children: state.map(
                    loading: (_) => <Widget>[
                      UiCard(
                        child: SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                    loaded: (state) {
                      return List.generate(
                        state.specializations.length,
                        (index) => _CarouselWrapper(
                          width: _itemWeight,
                          child: _CarouselItem(
                            spec: state.specializations[index],
                            onPressed: () {
                              _controller.animateToItem(
                                (index + 1) % state.specializations.length,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    error: (state) => <Widget>[
                      UiCard(
                        child: Center(
                          child: UiText.bodyLarge(
                            state.message,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _CarouselIndicators(
                countChildren: state.maybeMap(
                  orElse: () => 1,
                  loaded: (state) => state.specializations.length,
                ),
                controller: _controller,
                index: _index,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CarouselIndicators extends StatelessWidget {
  const _CarouselIndicators({
    required this.countChildren,
    required this.controller,
    required this.index,
  });

  final int countChildren;
  final CarouselController controller;
  final ValueNotifier<int> index;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            countChildren,
            (index) => GestureDetector(
              onTap: () => controller.animateToItem(
                index,
                duration: const Duration(milliseconds: 300),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                width: value == index ? 12 : 10,
                height: value == index ? 12 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value == index
                      ? color.accent.withValues(alpha: 0.7)
                      : color.accent.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.spec, required this.onPressed});

  final SpecializationEntity spec;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      UiText.titleLarge(spec.name),
      const SizedBox(height: 8),
      UiText.bodyLarge(spec.description),
    ],
  );
}

class _CarouselWrapper extends StatelessWidget {
  const _CarouselWrapper({required this.width, required this.child});

  final double width;
  final Widget child;

  static const _fadeOutThreshold = 100.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final opacity =
            max(0, constraints.maxWidth + _fadeOutThreshold - width) /
            _fadeOutThreshold;
        return UiCard(
          child: Opacity(
            opacity: opacity,
            child: OverflowBox(
              maxWidth: width,
              alignment: Alignment.topCenter,
              child: Padding(padding: _padding, child: child),
            ),
          ),
        );
      },
    );
  }
}
