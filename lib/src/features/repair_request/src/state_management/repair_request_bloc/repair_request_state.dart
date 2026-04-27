part of 'repair_request_bloc.dart';

typedef RepairRequestStateMatch<R, S extends RepairRequestState> =
    R Function(S state);

sealed class RepairRequestState {
  const RepairRequestState({required this.requests, required this.filter});

  final List<FullRepairRequest> requests;
  final RequestFilterType filter;

  List<FullRepairRequest> get filteredRequests => switch (filter) {
    .all => requests,
    .active =>
      requests
          .where((request) => request.currentStatus == .newRequest)
          .toList(),
  };

  RepairRequestState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  });

  const factory RepairRequestState.loading({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
  }) = _RepairRequestLoading;

  const factory RepairRequestState.loaded({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
  }) = _RepairRequestLoaded;

  const factory RepairRequestState.error({
    required List<FullRepairRequest> requests,
    required RequestFilterType filter,
    required Object message,
  }) = _RepairRequestError;

  R map<R>({
    required RepairRequestStateMatch<R, _RepairRequestLoading> loading,
    required RepairRequestStateMatch<R, _RepairRequestLoaded> loaded,
    required RepairRequestStateMatch<R, _RepairRequestError> error,
  }) => switch (this) {
    _RepairRequestLoading s => loading(s),
    _RepairRequestLoaded s => loaded(s),
    _RepairRequestError s => error(s),
  };

  R maybeMap<R>({
    RepairRequestStateMatch<R, _RepairRequestLoading>? loading,
    RepairRequestStateMatch<R, _RepairRequestLoaded>? loaded,
    RepairRequestStateMatch<R, _RepairRequestError>? error,
    required R Function(RepairRequestState) orElse,
  }) => map<R>(
    loading: loading ?? orElse,
    loaded: loaded ?? orElse,
    error: error ?? orElse,
  );

  R? mapOrNull<R>({
    RepairRequestStateMatch<R, _RepairRequestLoading>? loading,
    RepairRequestStateMatch<R, _RepairRequestLoaded>? loaded,
    RepairRequestStateMatch<R, _RepairRequestError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _RepairRequestLoading extends RepairRequestState {
  const _RepairRequestLoading({required super.requests, required super.filter});

  @override
  RepairRequestState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairRequestLoading(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
  );
}

final class _RepairRequestLoaded extends RepairRequestState {
  const _RepairRequestLoaded({required super.requests, required super.filter});

  @override
  RepairRequestState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairRequestLoaded(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
  );
}

final class _RepairRequestError extends RepairRequestState {
  const _RepairRequestError({
    required super.requests,
    required super.filter,
    required this.message,
  });

  final Object message;

  @override
  RepairRequestState copyWith({
    List<FullRepairRequest>? requests,
    RequestFilterType? filter,
  }) => _RepairRequestError(
    requests: requests ?? this.requests,
    filter: filter ?? this.filter,
    message: message,
  );
}
