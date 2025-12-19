part of 'dormitory_search_bloc.dart';

typedef DormitorySearchEventMatch<R, E extends DormitorySearchEvent> =
    R Function(E event);

sealed class DormitorySearchEvent {
  const DormitorySearchEvent({required this.text});
  final String text;

  const factory DormitorySearchEvent.textChanged({required String text}) =
      _SearchEventTextChanged;

  R map<R>({
    required DormitorySearchEventMatch<R, _SearchEventTextChanged> textChanged,
  }) => switch (this) {
    _SearchEventTextChanged e => textChanged(e),
  };

  R maybeMap<R>({
    DormitorySearchEventMatch<R, _SearchEventTextChanged>? textChanged,
    required R Function() orElse,
  }) => map<R>(textChanged: textChanged ?? (_) => orElse());

  R? mapOrNull<R>({
    DormitorySearchEventMatch<R, _SearchEventTextChanged>? textChanged,
  }) => map<R?>(textChanged: textChanged ?? (_) => null);
}

class _SearchEventTextChanged extends DormitorySearchEvent {
  const _SearchEventTextChanged({required super.text});
}
