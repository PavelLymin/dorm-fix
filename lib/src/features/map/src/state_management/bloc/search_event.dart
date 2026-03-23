part of 'search_bloc.dart';

typedef SearchEventMatch<R, E extends SearchEvent> =
    FutureOr<R> Function(E event);

sealed class SearchEvent {
  const SearchEvent({required this.query});

  final String query;

  const factory SearchEvent.queyChanged({required String query}) =
      _QueryChangedEvent;

  FutureOr<R> map<R>({
    required SearchEventMatch<R, _QueryChangedEvent> queyChanged,
  }) => switch (this) {
    _QueryChangedEvent e => queyChanged(e),
  };
}

class _QueryChangedEvent extends SearchEvent {
  const _QueryChangedEvent({required super.query});
}
