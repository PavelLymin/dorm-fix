import 'package:ui_kit/ui.dart';
import '../../../request.dart';

class RequestStatus extends StatefulWidget {
  const RequestStatus({
    super.key,
    required this.currentStatus,
    required this.status,
  });

  final StatusEnum currentStatus;
  final List<StatusEntity> status;

  @override
  State<RequestStatus> createState() => _RequestStatusState();
}

class _RequestStatusState extends State<RequestStatus> {
  late int _current;

  List<StepItem> _setSteps() {
    StatusEntity? first;
    StatusEntity? second;
    StatusEntity? last;

    for (int i = 0; i < widget.status.length; i++) {
      if (widget.status[i].title == widget.currentStatus) _current = i;

      if (i == 0) {
        first = widget.status[i];
      } else if (i == 1) {
        second = widget.status[i];
      } else if (i == widget.status.length - 1) {
        last = widget.status[i];
      }
    }

    return [
      first != null
          ? StepItem(
              title: first.title.value,
              subtitle: first.createdAt.toLocal().toIso8601String(),
            )
          : StepItem(title: StatusEnum.newRequest.value),
      second != null
          ? StepItem(
              title: second.title.value,
              subtitle: second.createdAt.toLocal().toIso8601String(),
            )
          : StepItem(title: StatusEnum.inProgress.value),
      last != null
          ? StepItem(
              title: last.title.value,
              subtitle: last.createdAt.toLocal().toIso8601String(),
            )
          : StepItem(title: StatusEnum.completed.value),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UiCard.standart(
        padding: .all(20.0),
        child: UiStepper(steps: _setSteps(), currentStep: _current),
      ),
    );
  }
}

class ButtonRequest extends StatefulWidget {
  const ButtonRequest({super.key, required this.status, required this.current});

  final StatusEnum status;
  final StatusEnum current;

  @override
  State<ButtonRequest> createState() => _ButtonRequestState();
}

class _ButtonRequestState extends State<ButtonRequest> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: .only(top: 32.0),
      sliver: SliverToBoxAdapter(
        child: UiButton.filledPrimary(
          onPressed: () {},
          icon: const Icon(Icons.cancel_outlined),
          label: Text('Отменить заявку'),
        ),
      ),
    );
  }
}
