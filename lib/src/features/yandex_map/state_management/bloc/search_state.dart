part of 'search_bloc.dart';

typedef SearchStateMatch<R, S extends SearchState> = R Function(S state);

sealed class SearchState {
  const SearchState({required this.dormitories});

  final List<FullDormitory> dormitories;

  const factory SearchState.loading({
    required List<FullDormitory> dormitories,
  }) = _SearchStateLoading;

  const factory SearchState.error({required List<FullDormitory> dormitories}) =
      _SearchStateError;

  const factory SearchState.noTerm({required List<FullDormitory> dormitories}) =
      _SearchStateNoTerm;

  const factory SearchState.searchPopulated({
    required List<FullDormitory> dormitories,
  }) = _SearchStateSearchPopulated;

  const factory SearchState.searchEmpty({
    required List<FullDormitory> dormitories,
  }) = _SearchStateSearchEmpty;

  R map<R>({
    required SearchStateMatch<R, _SearchStateLoading> loading,
    required SearchStateMatch<R, _SearchStateError> error,
    required SearchStateMatch<R, _SearchStateNoTerm> noTerm,
    required SearchStateMatch<R, _SearchStateSearchPopulated> searchPopulated,
    required SearchStateMatch<R, _SearchStateSearchEmpty> searchEmpty,
  }) => switch (this) {
    _SearchStateLoading s => loading(s),
    _SearchStateError s => error(s),
    _SearchStateNoTerm s => noTerm(s),
    _SearchStateSearchPopulated s => searchPopulated(s),
    _SearchStateSearchEmpty s => searchEmpty(s),
  };

  R maybeMap<R>({
    SearchStateMatch<R, _SearchStateLoading>? loading,
    SearchStateMatch<R, _SearchStateError>? error,
    SearchStateMatch<R, _SearchStateNoTerm>? noTerm,
    SearchStateMatch<R, _SearchStateSearchPopulated>? searchPopulated,
    SearchStateMatch<R, _SearchStateSearchEmpty>? searchEmpty,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
    noTerm: noTerm ?? (_) => orElse(),
    searchPopulated: searchPopulated ?? (_) => orElse(),
    searchEmpty: searchEmpty ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    SearchStateMatch<R, _SearchStateLoading>? loading,
    SearchStateMatch<R, _SearchStateError>? error,
    SearchStateMatch<R, _SearchStateNoTerm>? noTerm,
    SearchStateMatch<R, _SearchStateSearchPopulated>? searchPopulated,
    SearchStateMatch<R, _SearchStateSearchEmpty>? searchEmpty,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
    noTerm: noTerm ?? (_) => null,
    searchPopulated: searchPopulated ?? (_) => null,
    searchEmpty: searchEmpty ?? (_) => null,
  );
}

final class _SearchStateLoading extends SearchState {
  const _SearchStateLoading({required super.dormitories});
}

final class _SearchStateError extends SearchState {
  const _SearchStateError({required super.dormitories});
}

final class _SearchStateNoTerm extends SearchState {
  const _SearchStateNoTerm({required super.dormitories});
}

final class _SearchStateSearchPopulated extends SearchState {
  const _SearchStateSearchPopulated({required super.dormitories});
}

final class _SearchStateSearchEmpty extends SearchState {
  const _SearchStateSearchEmpty({required super.dormitories});
}
