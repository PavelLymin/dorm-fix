part of 'search_bloc.dart';

typedef SearchStateMatch<R, S extends SearchState> = R Function(S state);

sealed class SearchState {
  const SearchState({required this.dormitories});

  final List<DormitoryEntity> dormitories;

  const factory SearchState.loading({
    required List<DormitoryEntity> dormitories,
  }) = _SearchLoading;

  const factory SearchState.loaded({
    required List<DormitoryEntity> dormitories,
  }) = _SearchLoaded;

  const factory SearchState.error({
    required List<DormitoryEntity> dormitories,
    required Object error,
  }) = _SearchError;

  R map<R>({
    required SearchStateMatch<R, _SearchLoading> loading,
    required SearchStateMatch<R, _SearchLoaded> loaded,
    required SearchStateMatch<R, _SearchError> error,
  }) => switch (this) {
    _SearchLoading s => loading(s),
    _SearchLoaded s => loaded(s),
    _SearchError s => error(s),
  };

  R maybeMap<R>({
    SearchStateMatch<R, _SearchLoading>? loading,
    SearchStateMatch<R, _SearchLoaded>? loaded,
    SearchStateMatch<R, _SearchError>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    SearchStateMatch<R, _SearchLoading>? loading,
    SearchStateMatch<R, _SearchLoaded>? loaded,
    SearchStateMatch<R, _SearchError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _SearchLoading extends SearchState {
  const _SearchLoading({required super.dormitories});
}

final class _SearchLoaded extends SearchState {
  const _SearchLoaded({required super.dormitories});
}

final class _SearchError extends SearchState {
  const _SearchError({required super.dormitories, required this.error});

  final Object error;
}
