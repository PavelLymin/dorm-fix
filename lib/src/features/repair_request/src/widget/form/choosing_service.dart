import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../specialization/specialization.dart';
import '../../../request.dart';

class ChoosingService extends StatelessWidget {
  const ChoosingService({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loading: (state) => Shimmer(
            child: _SpecializationOptions(specialization: const [.fake()]),
          ),
          loaded: (state) =>
              _SpecializationOptions(specialization: state.specializations),
          error: (state) => UiText2.lBold(state.message.toString()),
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
  late final RequestFormBloc _requestFormBloc;
  late final List<ScrollableItem<int>> options;

  @override
  void initState() {
    super.initState();
    _requestFormBloc = context.read<RequestFormBloc>();
    options = widget.specialization
        .map(
          (specialization) => ScrollableItem(
            value: specialization.id,
            title: specialization.title,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return BlocBuilder<RequestFormBloc, RequestFormState>(
      buildWhen: (previous, current) =>
          previous.currentFormModel.specializationId !=
          current.currentFormModel.specializationId,
      builder: (context, state) => UiScrollableControl<int>(
        options: options,
        initial: state.currentFormModel.specializationId,
        style: ScrollableControlStyle(
          textStyle: TextStyle(color: palette.secondary),
        ),
        onChange: (id) {
          _requestFormBloc.add(.update(specializationId: id));
        },
      ),
    );
  }
}
