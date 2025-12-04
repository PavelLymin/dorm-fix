import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../home/home.dart';
import '../../request.dart';

class ChoosingService extends StatefulWidget {
  const ChoosingService({super.key});

  @override
  State<ChoosingService> createState() => _ChoosingServiceState();
}

class _ChoosingServiceState extends State<ChoosingService> {
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    _specializationBloc = DependeciesScope.of(context).specializationBloc;
  }

  @override
  void dispose() {
    _specializationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _specializationBloc,
    child: BlocBuilder<SpecializationBloc, SpecializationState>(
      builder: (context, state) => state.maybeMap(
        orElse: () => const Center(child: CircularProgressIndicator()),
        loaded: (state) =>
            _SpecializationOptions(specialization: state.specializations),
      ),
    ),
  );
}

class _SpecializationOptions extends StatefulWidget {
  const _SpecializationOptions({required this.specialization});

  final List<SpecializationEntity> specialization;

  @override
  State<_SpecializationOptions> createState() => _SpecializationOptionsState();
}

class _SpecializationOptionsState extends State<_SpecializationOptions> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  late final List<ChoiceItem> options;
  late RequestFormBloc _requestFormBloc;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    _requestFormBloc.add(
      RequestFormEvent.setRequestFormValue(
        masterId: widget.specialization.first.id,
      ),
    );
    options = widget.specialization
        .map((specialization) => ChoiceItem(title: specialization.title))
        .toList();
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (_, value, _) => ChoiceOptions(
        options: options,
        selected: value,
        barColor: colorPalette.secondary,
        selectedColor: colorPalette.primary,
        onChange: (index) {
          _requestFormBloc.add(
            RequestFormEvent.setRequestFormValue(
              masterId: widget.specialization.first.id,
            ),
          );
          setState(() {
            _selectedIndex.value = index;
          });
        },
      ),
    );
  }
}
