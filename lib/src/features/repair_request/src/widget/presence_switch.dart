import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../request.dart';

class PresenceSwitch extends StatelessWidget {
  const PresenceSwitch({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      UiText.titleMedium('Отсутствие в комнате'),
      BlocBuilder<RequestFormBloc, RequestFormState>(
        buildWhen: (previous, current) =>
            previous.currentFormModel.studentAbsent !=
            current.currentFormModel.studentAbsent,
        builder: (context, state) {
          return UiSwitch(
            value: state.currentFormModel.studentAbsent,
            onChanged: (value) {
              context.read<RequestFormBloc>().add(
                .updateRequestForm(studentAbsent: value),
              );
            },
          );
        },
      ),
    ],
  );
}
