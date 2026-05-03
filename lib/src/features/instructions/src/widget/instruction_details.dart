import 'package:ui_kit/ui.dart';
import '../../instructions.dart';

class InstructionDetails extends StatelessWidget {
  const InstructionDetails({super.key, required this.instruction});

  final InstructionEntity instruction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Совет')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const .only(top: 32.0),
                sliver: SliverToBoxAdapter(
                  child: _InstructionPhoto(images: [instruction.photoPath]),
                ),
              ),
              SliverPadding(
                padding: .only(top: 24.0, bottom: 12.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold(instruction.title),
                ),
              ),
              SliverList.separated(
                itemCount: instruction.steps.length,
                itemBuilder: (context, index) => const SizedBox(height: 8.0),
                separatorBuilder: (context, index) {
                  final step = instruction.steps[index];
                  return Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    spacing: 2.0,
                    mainAxisSize: .min,
                    children: [
                      UiText2.lBold(
                        step.isOptional ? 'Дополнительно' : 'Шаг ${step.step}',
                      ),
                      UiText2.m(step.description),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionPhoto extends StatelessWidget {
  const _InstructionPhoto({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return UiCarousel(
      constraints: const BoxConstraints(maxHeight: 110.0),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final photoPath = images[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: Theme.of(context).appStyle.borderRadius,
            image: DecorationImage(image: AssetImage(photoPath), fit: .cover),
          ),
        );
      },
    );
  }
}
