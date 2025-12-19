part of 'room_search_bloc_bloc.dart';

typedef RoomSearchStateMatch<R, S extends RoomSearchState> =
    R Function(S state);

sealed class RoomSearchState {
  const RoomSearchState({required this.rooms, required this.dormitoryId});

  final List<RoomEntity> rooms;
  final int? dormitoryId;

  const factory RoomSearchState.dormitoryChosen({
    required List<RoomEntity> rooms,
    required int dormitoryId,
  }) = _RoomSearchStateDormitoryChosen;

  const factory RoomSearchState.loading({
    required List<RoomEntity> rooms,
    int? dormitoryId,
  }) = _RoomSearchStateLoading;

  const factory RoomSearchState.error({
    required List<RoomEntity> rooms,
    int? dormitoryId,
    required String message,
  }) = _RoomSearchStateError;

  const factory RoomSearchState.noTerm({
    required List<RoomEntity> rooms,
    int? dormitoryId,
  }) = _RoomSearchStateNoTerm;

  const factory RoomSearchState.searchPopulated({
    required List<RoomEntity> rooms,
    int? dormitoryId,
  }) = _RoomSearchStateSearchPopulated;

  const factory RoomSearchState.searchEmpty({
    required List<RoomEntity> rooms,
    int? dormitoryId,
  }) = _RoomSearchStateSearchEmpty;

  R map<R>({
    required RoomSearchStateMatch<R, _RoomSearchStateDormitoryChosen>
    dormitoryChosen,
    required RoomSearchStateMatch<R, _RoomSearchStateLoading> loading,
    required RoomSearchStateMatch<R, _RoomSearchStateError> error,
    required RoomSearchStateMatch<R, _RoomSearchStateNoTerm> noTerm,
    required RoomSearchStateMatch<R, _RoomSearchStateSearchPopulated>
    searchPopulated,
    required RoomSearchStateMatch<R, _RoomSearchStateSearchEmpty> searchEmpty,
  }) => switch (this) {
    _RoomSearchStateDormitoryChosen s => dormitoryChosen(s),
    _RoomSearchStateLoading s => loading(s),
    _RoomSearchStateError s => error(s),
    _RoomSearchStateNoTerm s => noTerm(s),
    _RoomSearchStateSearchPopulated s => searchPopulated(s),
    _RoomSearchStateSearchEmpty s => searchEmpty(s),
  };

  R maybeMap<R>({
    RoomSearchStateMatch<R, _RoomSearchStateDormitoryChosen>? dormitoryChosen,
    RoomSearchStateMatch<R, _RoomSearchStateLoading>? loading,
    RoomSearchStateMatch<R, _RoomSearchStateError>? error,
    RoomSearchStateMatch<R, _RoomSearchStateNoTerm>? noTerm,
    RoomSearchStateMatch<R, _RoomSearchStateSearchPopulated>? searchPopulated,
    RoomSearchStateMatch<R, _RoomSearchStateSearchEmpty>? searchEmpty,
    required R Function() orElse,
  }) => map<R>(
    dormitoryChosen: dormitoryChosen ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
    noTerm: noTerm ?? (_) => orElse(),
    searchPopulated: searchPopulated ?? (_) => orElse(),
    searchEmpty: searchEmpty ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    RoomSearchStateMatch<R, _RoomSearchStateDormitoryChosen>? dormitoryChosen,
    RoomSearchStateMatch<R, _RoomSearchStateLoading>? loading,
    RoomSearchStateMatch<R, _RoomSearchStateError>? error,
    RoomSearchStateMatch<R, _RoomSearchStateNoTerm>? noTerm,
    RoomSearchStateMatch<R, _RoomSearchStateSearchPopulated>? searchPopulated,
    RoomSearchStateMatch<R, _RoomSearchStateSearchEmpty>? searchEmpty,
  }) => map<R?>(
    dormitoryChosen: dormitoryChosen ?? (_) => null,
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
    noTerm: noTerm ?? (_) => null,
    searchPopulated: searchPopulated ?? (_) => null,
    searchEmpty: searchEmpty ?? (_) => null,
  );
}

final class _RoomSearchStateDormitoryChosen extends RoomSearchState {
  const _RoomSearchStateDormitoryChosen({
    required super.rooms,
    required super.dormitoryId,
  });
}

final class _RoomSearchStateLoading extends RoomSearchState {
  const _RoomSearchStateLoading({required super.rooms, super.dormitoryId});
}

final class _RoomSearchStateError extends RoomSearchState {
  const _RoomSearchStateError({
    required super.rooms,
    super.dormitoryId,
    required this.message,
  });
  final String message;
}

final class _RoomSearchStateNoTerm extends RoomSearchState {
  const _RoomSearchStateNoTerm({required super.rooms, super.dormitoryId});
}

final class _RoomSearchStateSearchPopulated extends RoomSearchState {
  const _RoomSearchStateSearchPopulated({
    required super.rooms,
    super.dormitoryId,
  });
}

final class _RoomSearchStateSearchEmpty extends RoomSearchState {
  const _RoomSearchStateSearchEmpty({required super.rooms, super.dormitoryId});
}
