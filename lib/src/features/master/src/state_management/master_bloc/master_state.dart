part of 'master_bloc.dart';

typedef MasterStateMatch<R, S extends MasterState> = R Function(S state);

sealed class MasterState {
  const MasterState({required this.masters});

  final List<MasterUser> masters;

  const factory MasterState.loading({required List<MasterUser> masters}) =
      _MasterLoading;

  const factory MasterState.loaded({required List<MasterUser> masters}) =
      _MasterLoaded;

  const factory MasterState.error({
    required List<MasterUser> masters,
    required Object error,
  }) = _MasterError;

  R map<R>({
    required MasterStateMatch<R, _MasterLoading> loading,
    required MasterStateMatch<R, _MasterLoaded> loaded,
    required MasterStateMatch<R, _MasterError> error,
  }) => switch (this) {
    _MasterLoading s => loading(s),
    _MasterLoaded s => loaded(s),
    _MasterError s => error(s),
  };

  R maybeMap<R>({
    MasterStateMatch<R, _MasterLoading>? loading,
    MasterStateMatch<R, _MasterLoaded>? loaded,
    MasterStateMatch<R, _MasterError>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    MasterStateMatch<R, _MasterLoading>? loading,
    MasterStateMatch<R, _MasterLoaded>? loaded,
    MasterStateMatch<R, _MasterError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _MasterLoading extends MasterState {
  const _MasterLoading({required super.masters});
}

final class _MasterLoaded extends MasterState {
  const _MasterLoaded({required super.masters});
}

final class _MasterError extends MasterState {
  const _MasterError({required super.masters, required this.error});

  final Object error;
}
