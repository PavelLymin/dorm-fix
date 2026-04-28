part of 'repair_action_bloc.dart';

typedef RepairActionEventMatch<R, E extends RepairActionEvent> =
    FutureOr<R> Function(E event);

sealed class RepairActionEvent {
  const RepairActionEvent();

  const factory RepairActionEvent.create({required RequestFormModel request}) =
      _CreateRepairRequestsEvent;

  const factory RepairActionEvent.accept({required int requestId}) =
      _AcceptRepairRequestsEvent;

  FutureOr<R> map<R>({
    required RepairActionEventMatch<R, _CreateRepairRequestsEvent> create,
    required RepairActionEventMatch<R, _AcceptRepairRequestsEvent> accept,
  }) => switch (this) {
    _CreateRepairRequestsEvent e => create(e),
    _AcceptRepairRequestsEvent e => accept(e),
  };
}

final class _CreateRepairRequestsEvent extends RepairActionEvent {
  const _CreateRepairRequestsEvent({required this.request});

  final RequestFormModel request;
}

final class _AcceptRepairRequestsEvent extends RepairActionEvent {
  const _AcceptRepairRequestsEvent({required this.requestId});

  final int requestId;
}
