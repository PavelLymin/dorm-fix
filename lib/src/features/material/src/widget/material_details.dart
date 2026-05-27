import 'package:ui_kit/ui.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../material.dart';
import 'material_quantity.dart';

class MaterialDetails extends StatelessWidget {
  const MaterialDetails({super.key, required this.material});

  final MaterialEntity material;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(local.material)),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const .only(top: 32.0),
                sliver: SliverToBoxAdapter(
                  child: UiNetworkImage(images: [material.photoPath]),
                ),
              ),
              SliverPadding(
                padding: const .only(top: 32.0),
                sliver: SliverToBoxAdapter(
                  child: UiCard.standart(
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        UiText2.lBold(material.name),
                        UiText2.m('${material.quantity} шт.'),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const .only(top: 20.0),
                sliver: SliverToBoxAdapter(
                  child: UiButton.filledPrimary(
                    onPressed: () {
                      showUiBottomSheet(
                        context,
                        title: local.quantity,
                        widget: MaterialQuantity(material: material),
                      );
                    },
                    label: Text(local.change_quantity),
                  ),
                ),
              ),
              SliverPadding(
                padding: const .only(top: 24.0),
                sliver: SliverToBoxAdapter(
                  child: UiText2.lBold(local.description),
                ),
              ),
              SliverPadding(
                padding: const .only(top: 10.0),
                sliver: SliverToBoxAdapter(
                  child: UiCard.standart(
                    child: UiText2.m(material.description),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
