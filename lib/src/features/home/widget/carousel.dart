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
  final CarouselController _controller = CarouselController();
  late SpecializationBloc _specializationBloc;
  late double _itemWeight;

  @override
  void initState() {
    super.initState();
    _specializationBloc = DependeciesScope.of(context).specializationBloc;
    _specializationBloc.add(SpecializationEvent.getSpecializations());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemWeight =
        WindowSizeScope.of(context).width - AppPadding.defaultPadding * 3 * 2;
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _specializationBloc,
    child: BlocBuilder<SpecializationBloc, SpecializationState>(
      builder: (context, state) => Column(
        children: [
          SizedBox(
            height: 164,
            child: CarouselView(
              enableSplash: false,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              itemExtent: _itemWeight,
              itemSnapping: true,
              controller: _controller,
              children: state.map(
                loading: (_) => <Widget>[
                  UiCard(
                    child: const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
                loaded: (state) => List.generate(
                  state.specializations.length,
                  (index) => _CarouselWrapper(
                    itemWidth: _itemWeight,
                    child: _CarouselItem(
                      spec: state.specializations[index],
                      onPressed: () => _controller.animateToItem(
                        (index + 1) % state.specializations.length,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                ),
                error: (state) => <Widget>[
                  UiCard(
                    child: Center(
                      child: UiText.bodyLarge(state.message, softWrap: false),
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
            itemWeight: _itemWeight,
          ),
        ],
      ),
    ),
  );
}

class _CarouselIndicators extends StatefulWidget {
  const _CarouselIndicators({
    required this.countChildren,
    required this.controller,
    required this.itemWeight,
  });

  final int countChildren;
  final CarouselController controller;
  final double itemWeight;

  @override
  State<_CarouselIndicators> createState() => _CarouselIndicatorsState();
}

class _CarouselIndicatorsState extends State<_CarouselIndicators> {
  final ValueNotifier<int> _index = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    int index = (widget.controller.offset / widget.itemWeight).round();
    if (_index.value != index) {
      _index.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: _index,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.countChildren,
            (index) => GestureDetector(
              onTap: () => widget.controller.animateToItem(
                index,
                duration: const Duration(milliseconds: 300),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: SizedBox(
                  width: value == index ? 12 : 10,
                  height: value == index ? 12 : 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == index
                          ? color.accent.withValues(alpha: 0.7)
                          : color.accent.withValues(alpha: 0.3),
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
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({required this.spec, required this.onPressed});

  final SpecializationEntity spec;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Flexible(
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
      const SizedBox(width: 24),
      Image.asset('packages/ui_kit/assets/icons/${spec.photoUrl}', height: 84),
    ],
  );
}

class _CarouselWrapper extends StatelessWidget {
  const _CarouselWrapper({required this.itemWidth, required this.child});

  final double itemWidth;
  final Widget child;

  static const _fadeOutThreshold = 100.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) {
      final opacity =
          max(0, constraints.maxWidth + _fadeOutThreshold - itemWidth) /
          _fadeOutThreshold;
      return UiCard(
        padding: AppPadding.symmetricIncrement(horizontal: 3, vertical: 3),
        child: Opacity(
          opacity: opacity,
          child: OverflowBox(
            maxWidth: itemWidth - (3 * AppPadding.defaultPadding) * 2,
            maxHeight: constraints.maxHeight,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
      );
    },
  );
}
