part of 'repair_watcher_bloc.dart';

typedef RepairWatcherEventMatch<R, E extends RepairWatcherEvent> =
    FutureOr<R> Function(E event);

sealed class RepairWatcherEvent {
  const RepairWatcherEvent();

  factory RepairWatcherEvent.get({
    bool uid,
    int? specId,
    int? dormId,
    StatusEnum? status,
  }) = _GetRepairRequestsEvent;

  const factory RepairWatcherEvent.filterChanged({
    required RequestFilterType filter,
  }) = _FilterChangedEvent;

  FutureOr<R> map<R>({
    required RepairWatcherEventMatch<R, _GetRepairRequestsEvent> get,
    required RepairWatcherEventMatch<R, _FilterChangedEvent> filterChanged,
  }) => switch (this) {
    _GetRepairRequestsEvent e => get(e),
    _FilterChangedEvent e => filterChanged(e),
  };
}

final class _GetRepairRequestsEvent extends RepairWatcherEvent {
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

final class _FilterChangedEvent extends RepairWatcherEvent {
  const _FilterChangedEvent({required this.filter});

  final RequestFilterType filter;
}
