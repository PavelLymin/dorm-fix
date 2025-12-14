import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../home/home.dart';
import '../../request.dart';

class ChoosingService extends StatelessWidget {
  const ChoosingService({super.key, required this.selectedIndex});

  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const Center(child: CircularProgressIndicator()),
          error: (state) => UiText.bodyLarge(state.message),
          loaded: (state) => _SpecializationOptions(
            specialization: state.specializations,
            selectedIndex: selectedIndex,
          ),
        ),
      );
}

class _SpecializationOptions extends StatefulWidget {
  const _SpecializationOptions({
    required this.specialization,
    required this.selectedIndex,
  });

  final List<SpecializationEntity> specialization;
  final ValueNotifier<int> selectedIndex;

  @override
  State<_SpecializationOptions> createState() => _SpecializationOptionsState();
}

class _SpecializationOptionsState extends State<_SpecializationOptions> {
  late final List<ChoiceItem> options;

  @override
  void initState() {
    super.initState();
    final id = widget.specialization.first.id;
    context.read<RequestFormBloc>().add(
      .updateRequestForm(specializationId: id),
    );
    options = widget.specialization
        .map((specialization) => ChoiceItem(title: specialization.title))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: widget.selectedIndex,
      builder: (_, value, _) => ChoiceOptions(
        options: options,
        selected: value,
        barColor: colorPalette.secondary,
        selectedColor: colorPalette.primary,
        onChange: (index) {
          context.read<RequestFormBloc>().add(
            .updateRequestForm(
              specializationId: widget.specialization[index].id,
            ),
          );
          widget.selectedIndex.value = index;
        },
      ),
    );
  }
}
