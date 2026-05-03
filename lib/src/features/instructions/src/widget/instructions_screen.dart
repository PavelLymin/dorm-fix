import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../instructions.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Советы')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(slivers: [const _InstructionsList()]),
        ),
      ),
    );
  }
}

class _InstructionsList extends StatelessWidget {
  const _InstructionsList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typography = theme.appTypography2;
    return BlocBuilder<InstructionBloc, InstructionState>(
      builder: (context, state) {
        return SliverFixedExtentList.builder(
          itemCount: state.instructions.length,
          itemExtent: _Item.getExtent(typography),
          itemBuilder: (context, index) => Padding(
            padding: AppInsets.item,
            child: _Item(instruction: state.instructions[index]),
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.instruction});

  final InstructionEntity instruction;

  static const _titleSpacing = 2.0;
  static const _subTitleSpacing = 12.0;

  static double getExtent(AppTypography2 typography) {
    final title = TextPainter(textDirection: .ltr, maxLines: 1)
      ..text = TextSpan(style: typography.lBold)
      ..layout();

    final subTitle = TextPainter(textDirection: .ltr, maxLines: 1)
      ..text = TextSpan(style: typography.m)
      ..layout();

    final subTitle2 = TextPainter(textDirection: .ltr, maxLines: 2)
      ..text = TextSpan(text: 'text\ntext', style: typography.m)
      ..layout();

    return title.height +
        _titleSpacing +
        subTitle.height +
        _subTitleSpacing +
        subTitle2.height +
        AppInsets.card.vertical +
        AppInsets.item.vertical;
  }

  @override
  Widget build(BuildContext context) {
    return UiCard.clickable(
      onTap: () => context.router.push(
        NamedRoute('InstructionDetails', params: {'instruction': instruction}),
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          UiText2.lBold(instruction.title),
          const SizedBox(height: _titleSpacing),
          UiText2.m(
            '${instruction.complexity}, ${instruction.durationMinutes} мин.',
          ),
          const SizedBox(height: _subTitleSpacing),
          UiText2.m(instruction.steps.first.description, maxLines: 2),
        ],
      ),
    );
  }
}
