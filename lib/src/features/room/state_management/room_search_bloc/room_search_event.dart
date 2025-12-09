part of 'room_search_bloc_bloc.dart';

typedef RoomSearchEventMatch<R, E extends RoomSearchEvent> =
    R Function(E event);

sealed class RoomSearchEvent {
  const RoomSearchEvent();

  const factory RoomSearchEvent.textChanged({required String text}) =
      _SearchEventTextChanged;

  const factory RoomSearchEvent.chooseDormitory({required int dormitoryId}) =
      _SearchEventChooseDormitory;

  R map<R>({
    required RoomSearchEventMatch<R, _SearchEventTextChanged> textChanged,
    required RoomSearchEventMatch<R, _SearchEventChooseDormitory>
    chooseDormitory,
  }) => switch (this) {
    _SearchEventTextChanged e => textChanged(e),
    _SearchEventChooseDormitory e => chooseDormitory(e),
  };

  R maybeMap<R>({
    RoomSearchEventMatch<R, _SearchEventTextChanged>? textChanged,
    RoomSearchEventMatch<R, _SearchEventChooseDormitory>? chooseDormitory,
    required R Function() orElse,
  }) => map<R>(
    textChanged: textChanged ?? (_) => orElse(),
    chooseDormitory: chooseDormitory ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    RoomSearchEventMatch<R, _SearchEventTextChanged>? textChanged,
    RoomSearchEventMatch<R, _SearchEventChooseDormitory>? chooseDormitory,
  }) => map<R?>(
    textChanged: textChanged ?? (_) => null,
    chooseDormitory: chooseDormitory ?? (_) => null,
  );
}

class _SearchEventTextChanged extends RoomSearchEvent {
  const _SearchEventTextChanged({required this.text});
  final String text;
}

class _SearchEventChooseDormitory extends RoomSearchEvent {
  const _SearchEventChooseDormitory({required this.dormitoryId});
  final int dormitoryId;
}
