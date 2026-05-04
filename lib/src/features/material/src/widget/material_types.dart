import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../material.dart';

class MaterialTypes extends StatelessWidget {
  const MaterialTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialTypeBloc, MaterialTypeState>(
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
            context.read<MaterialTypeBloc>().add(.filterChanged(typeId: v));
            context.read<MaterialBloc>().add(.filterChanged(typeId: v));
          },
        );
      },
    );
  }
}
