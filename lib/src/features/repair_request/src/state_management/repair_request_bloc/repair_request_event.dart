part of 'repair_request_bloc.dart';

typedef RepairRequestEventMatch<R, E extends RepairRequestEvent> =
    FutureOr<R> Function(E event);

sealed class RepairRequestEvent {
  const RepairRequestEvent();

  factory RepairRequestEvent.get() = _GetRepairRequestsEvent;

  factory RepairRequestEvent.create({required RequestFormModel request}) =>
      _CreateRepairRequestsEvent(request: request);

  FutureOr<R> map<R>({
    required RepairRequestEventMatch<R, _GetRepairRequestsEvent> get,
    required RepairRequestEventMatch<R, _CreateRepairRequestsEvent> create,
  }) => switch (this) {
    _GetRepairRequestsEvent e => get(e),
    _CreateRepairRequestsEvent e => create(e),
  };
}

final class _GetRepairRequestsEvent extends RepairRequestEvent {
  const _GetRepairRequestsEvent();
}

final class _CreateRepairRequestsEvent extends RepairRequestEvent {
  const _CreateRepairRequestsEvent({required this.request});

  final RequestFormModel request;
}
