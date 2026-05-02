import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart' hide MaterialState;
import '../../../../material/material.dart';

class SelectionMaterialsScreen extends StatelessWidget {
  const SelectionMaterialsScreen({super.key, required this.materialsNotifier});

  final MaterialsUsedController materialsNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const .only(top: 16.0, bottom: 10.0),
          child: BlocBuilder<MaterialTypeBloc, MaterialTypeState>(
            builder: (context, state) {
              final types = state.materialTypes;
              return UiScrollableControl<int>(
                options: List.generate(types.length + 1, (index) {
                  if (index == 0) return ScrollableItem(value: 0, title: 'Все');
                  final type = types[index - 1];
                  return ScrollableItem(value: type.id, title: type.name);
                }),
                initial: context.read<MaterialBloc>().state.typeId ?? 0,
                onChange: (v) {
                  context.read<MaterialTypeBloc>().add(
                    .filterChanged(typeId: v),
                  );
                  context.read<MaterialBloc>().add(.filterChanged(typeId: v));
                },
              );
            },
          ),
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
                            materialsNotifier: materialsNotifier,
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
    required this.materialsNotifier,
  });

  final MaterialEntity material;
  final MaterialsUsedController materialsNotifier;

  @override
  State<_ItemIndicator> createState() => __ItemIndicatorState();
}

class __ItemIndicatorState extends State<_ItemIndicator> {
  late final ValueNotifier<int> _count;

  @override
  void initState() {
    super.initState();
    _count = ValueNotifier(
      widget.materialsNotifier.value[widget.material.id]?.quantity ?? 0,
    );
    _count.addListener(_countChanged);
  }

  @override
  void dispose() {
    _count.removeListener(_countChanged);
    _count.dispose();
    super.dispose();
  }

  void _countChanged() {
    if (_count.value == 0) {
      widget.materialsNotifier.removeMaterial(widget.material.id);
      return;
    }
    widget.materialsNotifier.addMaterial(
      widget.material.id,
      widget.material.name,
      _count.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.appStyle;
    final countWidth = 26.0 + 20.0;
    final width = style.iconSize * 2 + countWidth;
    return SizedBox(
      width: width,
      child: Align(
        alignment: .centerRight,
        child: ValueListenableBuilder(
          valueListenable: _count,
          builder: (_, count, _) {
            if (count == 0) {
              return UiButton.icon(
                style: ButtonStyle(
                  padding: .all(.zero),
                  minimumSize: .all(.zero),
                  tapTargetSize: .shrinkWrap,
                ),
                onPressed: () => _count.value++,
                icon: const Icon(UiIcons.plus),
              );
            }
            return Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .end,
              mainAxisSize: .min,
              children: [
                UiButton.icon(
                  style: ButtonStyle(
                    padding: .all(.zero),
                    minimumSize: .all(.zero),
                    tapTargetSize: .shrinkWrap,
                  ),
                  onPressed: () => _count.value++,
                  icon: const Icon(UiIcons.plus),
                ),
                SizedBox(
                  width: countWidth,
                  child: UiText2.m(textAlign: .center, count.toString()),
                ),
                UiButton.icon(
                  style: ButtonStyle(
                    padding: .all(.zero),
                    minimumSize: .all(.zero),
                    tapTargetSize: .shrinkWrap,
                  ),
                  onPressed: () => _count.value--,
                  icon: const Icon(UiIcons.menu),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
