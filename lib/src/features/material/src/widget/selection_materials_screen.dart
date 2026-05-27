import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart' hide MaterialState;
import '../../material.dart';
import 'material_types.dart';

class SelectionMaterialsScreen extends StatelessWidget {
  const SelectionMaterialsScreen({
    super.key,
    required this.materialsController,
  });

  final MaterialsUsedController materialsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: .only(top: 16.0, bottom: 10.0),
          child: MaterialTypes(),
        ),
        Expanded(
          child: Padding(
            padding: const .symmetric(vertical: 10.0),
            child: BlocBuilder<MaterialBloc, MaterialState>(
              builder: (context, state) {
                final materials = state.filteredMaterials;
                return ListView.separated(
                  itemCount: materials.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return UiCard.standart(
                      padding: .symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .center,
                        spacing: 12.0,
                        children: [
                          Flexible(child: UiText2.m(material.name)),
                          _ItemIndicator(
                            material: material,
                            materialsController: materialsController,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemIndicator extends StatefulWidget {
  const _ItemIndicator({
    required this.material,
    required this.materialsController,
  });

  final MaterialEntity material;
  final MaterialsUsedController materialsController;

  @override
  State<_ItemIndicator> createState() => __ItemIndicatorState();
}

class __ItemIndicatorState extends State<_ItemIndicator> {
  late final MaterialQuantityNotifier _quentityController;

  @override
  void initState() {
    super.initState();
    _quentityController = MaterialQuantityNotifier(
      widget.materialsController.value[widget.material.id]?.selectedAmount ?? 0,
      maxQuantity: widget.material.quantity,
    );
  }

  @override
  void dispose() {
    _quentityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.appStyle;
    final countWidth = 26.0 + 20.0;
    final width = style.iconSize * 2 + countWidth;
    return SizedBox(
      width: width,
      child: UiCounter(
        onIncrement: () => _quentityController.increment(widget.material),
        onDecrement: () => _quentityController.decrement(widget.material),
        valueListenable: _quentityController,
      ),
    );
  }
}
