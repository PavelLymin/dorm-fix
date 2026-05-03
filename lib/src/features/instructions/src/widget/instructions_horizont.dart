import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../instructions.dart';

class InstructionsHorizont extends StatefulWidget {
  const InstructionsHorizont({super.key, this.itemCount});

  final int? itemCount;

  @override
  State<InstructionsHorizont> createState() => _InstructionsHorizontState();
}

class _InstructionsHorizontState extends State<InstructionsHorizont> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  void _jumpToEnd() {
    if (_controller.hasClients) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      mainAxisSize: .min,
      spacing: 10.0,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            UiText2.lBold('Советы по ремонту'),
            UiButton.icon(
              onPressed: _jumpToEnd,
              icon: const Icon(UiIcons.chevronRight),
              style: ButtonStyle(backgroundColor: .all(palette.background)),
            ),
          ],
        ),
        SizedBox(
          height: 140.0,
          child: BlocBuilder<InstructionBloc, InstructionState>(
            builder: (context, state) {
              final length = state.instructions.length;
              final itemCount =
                  (widget.itemCount != null && widget.itemCount! <= length)
                  ? widget.itemCount!
                  : length;
              return ListView.separated(
                controller: _controller,
                itemCount: itemCount + 1,
                scrollDirection: .horizontal,
                padding: .zero,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 12.0),
                itemBuilder: (context, index) {
                  if (index >= itemCount) {
                    return _InstructionContent(
                      onTap: () => context.router.push(
                        const NamedRoute('InstructionsScreen'),
                      ),
                    );
                  }
                  final instruction = state.instructions[index];
                  return _InstructionContent(
                    instruction: instruction,
                    onTap: () => context.router.push(
                      NamedRoute(
                        'InstructionDetails',
                        params: {'instruction': instruction},
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _InstructionContent extends StatelessWidget {
  const _InstructionContent({this.instruction, required this.onTap});

  final InstructionEntity? instruction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return SizedBox.square(
      dimension: 140.0,
      child: UiCard.clickable(
        onTap: onTap,
        padding: const .only(left: 20.0, top: 12.0, right: 20.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            if (instruction != null) UiText2.m(instruction!.title),
            if (instruction == null) UiText2.m('Все советы'),
            const Spacer(),
            if (instruction != null)
              UiText2.m(
                instruction!.complexity,
                color: palette.foregroundSecondary,
              ),
            if (instruction == null)
              UiText2.m('Далее', color: palette.foregroundSecondary),
            if (instruction != null) const SizedBox(height: 4.0),
            if (instruction != null)
              UiText2.m(
                '${instruction!.durationMinutes} мин.',
                color: palette.foregroundSecondary,
              ),
          ],
        ),
      ),
    );
  }
}
