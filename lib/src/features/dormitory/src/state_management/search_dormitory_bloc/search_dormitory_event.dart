part of 'search_dormitory_bloc.dart';

typedef SearchEventMatch<R, E extends SearchDormitoryEvent> =
    FutureOr<R> Function(E event);

sealed class SearchDormitoryEvent {
  const SearchDormitoryEvent();

  const factory SearchDormitoryEvent.fetch({String? query}) =
      _FetchDormitoriesEvent;

  FutureOr<R> map<R>({
    required SearchEventMatch<R, _FetchDormitoriesEvent> fetch,
  }) => switch (this) {
    _FetchDormitoriesEvent e => fetch(e),
  };
}

class _FetchDormitoriesEvent extends SearchDormitoryEvent {
  const _FetchDormitoriesEvent({this.query});

  final String? query;
}
