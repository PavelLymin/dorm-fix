part of 'repair_request_bloc.dart';

typedef RepairRequestEventMatch<R, E extends RepairRequestEvent> =
    FutureOr<R> Function(E event);

sealed class RepairRequestEvent {
  const RepairRequestEvent();

  factory RepairRequestEvent.get({
    bool uid,
    int? specId,
    int? dormId,
    StatusEnum? status,
  }) = _GetRepairRequestsEvent;

  factory RepairRequestEvent.create({required RequestFormModel request}) =>
      _CreateRepairRequestsEvent(request: request);

  const factory RepairRequestEvent.filterChanged({
    required RequestFilterType filter,
  }) = _FilterChangedEvent;

  FutureOr<R> map<R>({
    required RepairRequestEventMatch<R, _GetRepairRequestsEvent> get,
    required RepairRequestEventMatch<R, _CreateRepairRequestsEvent> create,
    required RepairRequestEventMatch<R, _FilterChangedEvent> filterChanged,
  }) => switch (this) {
    _GetRepairRequestsEvent e => get(e),
    _CreateRepairRequestsEvent e => create(e),
    _FilterChangedEvent e => filterChanged(e),
  };
}

final class _GetRepairRequestsEvent extends RepairRequestEvent {
  const _GetRepairRequestsEvent({
    this.uid = false,
    this.specId,
    this.dormId,
    this.status,
  });

  final bool uid;
  final int? specId;
  final int? dormId;
  final StatusEnum? status;
}

final class _CreateRepairRequestsEvent extends RepairRequestEvent {
  const _CreateRepairRequestsEvent({required this.request});

  final RequestFormModel request;
}

final class _FilterChangedEvent extends RepairRequestEvent {
  const _FilterChangedEvent({required this.filter});

  final RequestFilterType filter;
}
