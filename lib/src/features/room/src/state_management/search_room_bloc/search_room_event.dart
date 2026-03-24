part of 'search_room_bloc.dart';

typedef SearchRoomEventMatch<R, E extends SearchRoomEvent> =
    R Function(E event);

sealed class SearchRoomEvent {
  const SearchRoomEvent();

  const factory SearchRoomEvent.fetch({String? query}) = _FetchRoomsEvent;

  R map<R>({required SearchRoomEventMatch<R, _FetchRoomsEvent> fetch}) =>
      switch (this) {
        _FetchRoomsEvent e => fetch(e),
      };
}

class _FetchRoomsEvent extends SearchRoomEvent {
  const _FetchRoomsEvent({this.query});

  final String? query;
}
