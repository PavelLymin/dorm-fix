part of 'dormitory_search_bloc.dart';

typedef DormitorySearchStateMatch<R, S extends DormitorySearchState> =
    R Function(S state);

sealed class DormitorySearchState {
  const DormitorySearchState({required this.dormitories});

  final List<DormitoryEntity> dormitories;

  const factory DormitorySearchState.loading({
    required List<DormitoryEntity> dormitories,
  }) = _SearchStateLoading;

  const factory DormitorySearchState.error({
    required List<DormitoryEntity> dormitories,
    required String message,
  }) = _SearchStateError;

  const factory DormitorySearchState.noTerm({
    required List<DormitoryEntity> dormitories,
  }) = _SearchStateNoTerm;

  const factory DormitorySearchState.searchPopulated({
    required List<DormitoryEntity> dormitories,
  }) = _SearchStateSearchPopulated;

  const factory DormitorySearchState.searchEmpty({
    required List<DormitoryEntity> dormitories,
  }) = _SearchStateSearchEmpty;

  R map<R>({
    required DormitorySearchStateMatch<R, _SearchStateLoading> loading,
    required DormitorySearchStateMatch<R, _SearchStateError> error,
    required DormitorySearchStateMatch<R, _SearchStateNoTerm> noTerm,
    required DormitorySearchStateMatch<R, _SearchStateSearchPopulated>
    searchPopulated,
    required DormitorySearchStateMatch<R, _SearchStateSearchEmpty> searchEmpty,
  }) => switch (this) {
    _SearchStateLoading s => loading(s),
    _SearchStateError s => error(s),
    _SearchStateNoTerm s => noTerm(s),
    _SearchStateSearchPopulated s => searchPopulated(s),
    _SearchStateSearchEmpty s => searchEmpty(s),
  };

  R maybeMap<R>({
    DormitorySearchStateMatch<R, _SearchStateLoading>? loading,
    DormitorySearchStateMatch<R, _SearchStateError>? error,
    DormitorySearchStateMatch<R, _SearchStateNoTerm>? noTerm,
    DormitorySearchStateMatch<R, _SearchStateSearchPopulated>? searchPopulated,
    DormitorySearchStateMatch<R, _SearchStateSearchEmpty>? searchEmpty,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
    noTerm: noTerm ?? (_) => orElse(),
    searchPopulated: searchPopulated ?? (_) => orElse(),
    searchEmpty: searchEmpty ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    DormitorySearchStateMatch<R, _SearchStateLoading>? loading,
    DormitorySearchStateMatch<R, _SearchStateError>? error,
    DormitorySearchStateMatch<R, _SearchStateNoTerm>? noTerm,
    DormitorySearchStateMatch<R, _SearchStateSearchPopulated>? searchPopulated,
    DormitorySearchStateMatch<R, _SearchStateSearchEmpty>? searchEmpty,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
    noTerm: noTerm ?? (_) => null,
    searchPopulated: searchPopulated ?? (_) => null,
    searchEmpty: searchEmpty ?? (_) => null,
  );
}

final class _SearchStateLoading extends DormitorySearchState {
  const _SearchStateLoading({required super.dormitories});
}

final class _SearchStateError extends DormitorySearchState {
  const _SearchStateError({required super.dormitories, required this.message});
  final String message;
}

final class _SearchStateNoTerm extends DormitorySearchState {
  const _SearchStateNoTerm({required super.dormitories});
}

final class _SearchStateSearchPopulated extends DormitorySearchState {
  const _SearchStateSearchPopulated({required super.dormitories});
}

final class _SearchStateSearchEmpty extends DormitorySearchState {
  const _SearchStateSearchEmpty({required super.dormitories});
}
