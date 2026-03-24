part of 'search_dormitory_bloc.dart';

typedef SearchStateMatch<R, S extends SearchDormitoryState> =
    R Function(S state);

sealed class SearchDormitoryState {
  const SearchDormitoryState({required this.dormitories});

  final List<DormitoryEntity> dormitories;

  const factory SearchDormitoryState.loading({
    required List<DormitoryEntity> dormitories,
  }) = _SearchDormitoryLoading;

  const factory SearchDormitoryState.loaded({
    required List<DormitoryEntity> dormitories,
  }) = _SearchDormitoryLoaded;

  const factory SearchDormitoryState.error({
    required List<DormitoryEntity> dormitories,
    required Object error,
  }) = _SearchDormitoryError;

  R map<R>({
    required SearchStateMatch<R, _SearchDormitoryLoading> loading,
    required SearchStateMatch<R, _SearchDormitoryLoaded> loaded,
    required SearchStateMatch<R, _SearchDormitoryError> error,
  }) => switch (this) {
    _SearchDormitoryLoading s => loading(s),
    _SearchDormitoryLoaded s => loaded(s),
    _SearchDormitoryError s => error(s),
  };

  R maybeMap<R>({
    SearchStateMatch<R, _SearchDormitoryLoading>? loading,
    SearchStateMatch<R, _SearchDormitoryLoaded>? loaded,
    SearchStateMatch<R, _SearchDormitoryError>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    SearchStateMatch<R, _SearchDormitoryLoading>? loading,
    SearchStateMatch<R, _SearchDormitoryLoaded>? loaded,
    SearchStateMatch<R, _SearchDormitoryError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _SearchDormitoryLoading extends SearchDormitoryState {
  const _SearchDormitoryLoading({required super.dormitories});
}

final class _SearchDormitoryLoaded extends SearchDormitoryState {
  const _SearchDormitoryLoaded({required super.dormitories});
}

final class _SearchDormitoryError extends SearchDormitoryState {
  const _SearchDormitoryError({
    required super.dormitories,
    required this.error,
  });

  final Object error;
}
