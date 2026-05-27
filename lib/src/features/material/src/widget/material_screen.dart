import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/l10n/gen/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart' hide MaterialState;
import '../../material.dart';
import 'material_types.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).materials)),
      body: Padding(
        padding: AppInsets.screen,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              const Padding(padding: .only(top: 10.0), child: MaterialTypes()),
              const _Searcher(),
              Expanded(
                child: BlocBuilder<MaterialBloc, MaterialState>(
                  builder: (context, state) {
                    final materials = state.filteredMaterials;
                    return ListView.builder(
                      itemCount: materials.length,
                      itemExtent: _Item.getExtent(theme),
                      itemBuilder: (context, index) =>
                          _Item(material: materials[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.material});

  final MaterialEntity material;

  static const double spacing = 6.0;

  static double getExtent(ThemeData theme) {
    final typography = theme.appTypography2;
    final title = TextPainter(
      text: TextSpan(text: 'text\ntext', style: typography.lBold),
      textDirection: .ltr,
      maxLines: 2,
    )..layout();
    final quantity = TextPainter(
      text: TextSpan(style: typography.m),
      textDirection: .ltr,
      maxLines: 1,
    )..layout();
    final description = TextPainter(
      text: TextSpan(text: 'text\ntext', style: typography.m),
      textDirection: .ltr,
      maxLines: 2,
    )..layout();

    return title.height +
        spacing +
        quantity.height +
        spacing +
        description.height +
        AppInsets.item.vertical +
        AppInsets.card.vertical;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Padding(
      padding: AppInsets.item,
      child: UiCard.clickable(
        onTap: () {
          context.router.push(
            NamedRoute('MaterialDetails', params: {'material': material}),
          );
        },
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            UiText2.lBold(material.name, maxLines: 2),
            const Spacer(),
            UiText2.m('${material.quantity} шт.'),
            const SizedBox(height: spacing),
            UiText2.m(
              material.description,
              maxLines: 2,
              color: palette.foregroundSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _Searcher extends StatefulWidget {
  const _Searcher();

  @override
  State<_Searcher> createState() => __SearcherState();
}

class __SearcherState extends State<_Searcher> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(top: 16.0, bottom: 10.0),
      child: UiTextField.search(
        controller: _controller,
        onChanged: context.read<MaterialBloc>().onQueryChanged.add,
        style: .new(hintText: AppLocalizations.of(context).search),
      ),
    );
  }
}
