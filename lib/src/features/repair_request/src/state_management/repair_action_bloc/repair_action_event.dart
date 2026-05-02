part of 'repair_action_bloc.dart';

typedef RepairActionEventMatch<R, E extends RepairActionEvent> =
    FutureOr<R> Function(E event);

sealed class RepairActionEvent {
  const RepairActionEvent();

  const factory RepairActionEvent.create({required RequestFormModel request}) =
      _CreateRepairRequestsEvent;

  const factory RepairActionEvent.accept({required int requestId}) =
      _AcceptRepairRequestsEvent;

  const factory RepairActionEvent.complete({
    required int requestId,
    Map<int, int>? materialUsage,
  }) = _CompleteRepairRequestsEvent;

  const factory RepairActionEvent.updateStatus({
    required int id,
    required StatusEnum status,
  }) = _UpdateStatusRepairRequestsEvent;

  FutureOr<R> map<R>({
    required RepairActionEventMatch<R, _CreateRepairRequestsEvent> create,
    required RepairActionEventMatch<R, _AcceptRepairRequestsEvent> accept,
    required RepairActionEventMatch<R, _CompleteRepairRequestsEvent> complete,
    required RepairActionEventMatch<R, _UpdateStatusRepairRequestsEvent>
    updateStatus,
  }) => switch (this) {
    _CreateRepairRequestsEvent e => create(e),
    _AcceptRepairRequestsEvent e => accept(e),
    _CompleteRepairRequestsEvent e => complete(e),
    _UpdateStatusRepairRequestsEvent e => updateStatus(e),
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

final class _CompleteRepairRequestsEvent extends RepairActionEvent {
  const _CompleteRepairRequestsEvent({
    required this.requestId,
    this.materialUsage,
  });

  final int requestId;
  final Map<int, int>? materialUsage;
}

final class _UpdateStatusRepairRequestsEvent extends RepairActionEvent {
  const _UpdateStatusRepairRequestsEvent({
    required this.id,
    required this.status,
  });

  final int id;
  final StatusEnum status;
}
