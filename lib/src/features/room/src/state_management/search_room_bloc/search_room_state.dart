part of 'search_room_bloc.dart';

typedef SearchRoomStateMatch<R, S extends SearchRoomState> =
    R Function(S state);

sealed class SearchRoomState {
  const SearchRoomState({required this.rooms});

  final List<RoomEntity> rooms;

  const factory SearchRoomState.loading({required List<RoomEntity> rooms}) =
      _SearchRoomLoading;

  const factory SearchRoomState.loaded({required List<RoomEntity> rooms}) =
      _SearchRoomLoaded;

  const factory SearchRoomState.error({
    required List<RoomEntity> rooms,
    required Object error,
  }) = _SearchRoomErrror;

  R map<R>({
    required SearchRoomStateMatch<R, _SearchRoomLoading> loading,
    required SearchRoomStateMatch<R, _SearchRoomLoaded> loaded,
    required SearchRoomStateMatch<R, _SearchRoomErrror> error,
  }) => switch (this) {
    _SearchRoomLoading s => loading(s),
    _SearchRoomLoaded s => loaded(s),
    _SearchRoomErrror s => error(s),
  };

  R maybeMap<R>({
    SearchRoomStateMatch<R, _SearchRoomLoading>? loading,
    SearchRoomStateMatch<R, _SearchRoomLoaded>? loaded,
    SearchRoomStateMatch<R, _SearchRoomErrror>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    SearchRoomStateMatch<R, _SearchRoomLoading>? loading,
    SearchRoomStateMatch<R, _SearchRoomLoaded>? loaded,
    SearchRoomStateMatch<R, _SearchRoomErrror>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _SearchRoomLoading extends SearchRoomState {
  const _SearchRoomLoading({required super.rooms});
}

final class _SearchRoomLoaded extends SearchRoomState {
  const _SearchRoomLoaded({required super.rooms});
}

final class _SearchRoomErrror extends SearchRoomState {
  const _SearchRoomErrror({required super.rooms, required this.error});

  final Object error;
}
