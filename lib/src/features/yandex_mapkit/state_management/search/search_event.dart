part of 'search_bloc.dart';

typedef SearchEventMatch<R, E extends SearchEvent> = R Function(E event);

sealed class SearchEvent {
  const SearchEvent({required this.text});
  final String text;

  const factory SearchEvent.textChanged({required String text}) =
      _SearchEventTextChanged;

  R map<R>({
    required SearchEventMatch<R, _SearchEventTextChanged> textChanged,
  }) => switch (this) {
    _SearchEventTextChanged e => textChanged(e),
  };

  R maybeMap<R>({
    SearchEventMatch<R, _SearchEventTextChanged>? textChanged,
    required R Function() orElse,
  }) => map<R>(textChanged: textChanged ?? (_) => orElse());

  R? mapOrNull<R>({
    SearchEventMatch<R, _SearchEventTextChanged>? textChanged,
  }) => map<R?>(textChanged: textChanged ?? (_) => null);
}

class _SearchEventTextChanged extends SearchEvent {
  const _SearchEventTextChanged({required super.text});
}
