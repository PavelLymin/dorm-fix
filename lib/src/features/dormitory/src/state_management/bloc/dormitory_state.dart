part of 'dormitory_bloc.dart';

typedef DormitoryStateMatch<R, S extends DormitoryState> = R Function(S state);

sealed class DormitoryState {
  const DormitoryState({required this.dormitories});

  final List<DormitoryEntity> dormitories;

  const factory DormitoryState.loading({
    required List<DormitoryEntity> dormitories,
  }) = _DormitoryLoading;

  const factory DormitoryState.loaded({
    required List<DormitoryEntity> dormitories,
  }) = _DormitoryLoaded;

  const factory DormitoryState.error({
    required List<DormitoryEntity> dormitories,
    required Object message,
  }) = _DormitoryError;

  R map<R>({
    required DormitoryStateMatch<R, _DormitoryLoading> loading,
    required DormitoryStateMatch<R, _DormitoryLoaded> loaded,
    required DormitoryStateMatch<R, _DormitoryError> error,
  }) => switch (this) {
    _DormitoryLoading s => loading(s),
    _DormitoryLoaded s => loaded(s),
    _DormitoryError s => error(s),
  };

  R maybeMap<R>({
    DormitoryStateMatch<R, _DormitoryLoading>? loading,
    DormitoryStateMatch<R, _DormitoryLoaded>? loaded,
    DormitoryStateMatch<R, _DormitoryError>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    DormitoryStateMatch<R, _DormitoryLoading>? loading,
    DormitoryStateMatch<R, _DormitoryLoaded>? loaded,
    DormitoryStateMatch<R, _DormitoryError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _DormitoryLoading extends DormitoryState {
  const _DormitoryLoading({required super.dormitories});
}

final class _DormitoryLoaded extends DormitoryState {
  const _DormitoryLoaded({required super.dormitories});
}

final class _DormitoryError extends DormitoryState {
  const _DormitoryError({required super.dormitories, required this.message});

  final Object message;
}
