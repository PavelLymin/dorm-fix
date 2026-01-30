part of 'repair_request_bloc.dart';

typedef RepairRequestStateMatch<R, S extends RepairRequestState> =
    R Function(S state);

sealed class RepairRequestState {
  const RepairRequestState({required this.requests});

  final List<FullRepairRequest> requests;

  factory RepairRequestState.loading({
    required List<FullRepairRequest> requests,
  }) = _RepairRequestLoading;

  factory RepairRequestState.loaded({
    required List<FullRepairRequest> requests,
  }) = _RepairRequestLoaded;

  factory RepairRequestState.error({
    required List<FullRepairRequest> requests,
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
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
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
  const _RepairRequestLoading({required super.requests});
}

final class _RepairRequestLoaded extends RepairRequestState {
  const _RepairRequestLoaded({required super.requests});
}

final class _RepairRequestError extends RepairRequestState {
  const _RepairRequestError({required super.requests, required this.message});

  final Object message;
}
