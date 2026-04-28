part of 'repair_watcher_bloc.dart';

typedef RepairWatcherStateMatch<R, S extends RepairWatcherState> =
    R Function(S state);

sealed class RepairWatcherState {
  const RepairWatcherState({required this.requests, required this.filter});

  final List<FullRepairRequest> requests;
  final RequestFilterType filter;

  const factory RepairWatcherState.loading({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
  }) = _RepairWatcherLoading;

  const factory RepairWatcherState.loaded({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
  }) = _RepairWatcherLoaded;

  const factory RepairWatcherState.error({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
    required Object message,
  }) = _RepairWatcherError;

  R map<R>({
    required RepairWatcherStateMatch<R, _RepairWatcherLoading> loading,
    required RepairWatcherStateMatch<R, _RepairWatcherLoaded> loaded,
    required RepairWatcherStateMatch<R, _RepairWatcherError> error,
  }) => switch (this) {
    _RepairWatcherLoading s => loading(s),
    _RepairWatcherLoaded s => loaded(s),
    _RepairWatcherError s => error(s),
  };

  R maybeMap<R>({
    RepairWatcherStateMatch<R, _RepairWatcherLoading>? loading,
    RepairWatcherStateMatch<R, _RepairWatcherLoaded>? loaded,
    RepairWatcherStateMatch<R, _RepairWatcherError>? error,
    required R Function(RepairWatcherState) orElse,
  }) => map<R>(
    loading: loading ?? orElse,
    loaded: loaded ?? orElse,
    error: error ?? orElse,
  );

  R? mapOrNull<R>({
    RepairWatcherStateMatch<R, _RepairWatcherLoading>? loading,
    RepairWatcherStateMatch<R, _RepairWatcherLoaded>? loaded,
    RepairWatcherStateMatch<R, _RepairWatcherError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );

  List<FullRepairRequest> get filteredRequests => switch (filter) {
    .all => requests,
    .active =>
      requests
          .where((request) => request.currentStatus == .inProgress)
          .toList(),
  };

  RepairWatcherState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  });
}

final class _RepairWatcherLoading extends RepairWatcherState {
  const _RepairWatcherLoading({required super.requests, required super.filter});

  @override
  RepairWatcherState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairWatcherLoading(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
  );
}

final class _RepairWatcherLoaded extends RepairWatcherState {
  const _RepairWatcherLoaded({required super.requests, required super.filter});

  @override
  RepairWatcherState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairWatcherLoaded(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
  );
}

final class _RepairWatcherError extends RepairWatcherState {
  const _RepairWatcherError({
    required super.requests,
    required super.filter,
    required this.message,
  });

  final Object message;

  @override
  RepairWatcherState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairWatcherError(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
    message: message,
  );
}
