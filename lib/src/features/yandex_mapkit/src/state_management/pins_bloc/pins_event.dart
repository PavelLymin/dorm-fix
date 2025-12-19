part of 'pins_bloc.dart';

typedef PinsEventMatch<R, E extends PinsEvent> = R Function(E event);

sealed class PinsEvent {
  const PinsEvent();

  factory PinsEvent.get() = _PinsEventGet;

  R map<R>({required PinsEventMatch<R, _PinsEventGet> get}) => switch (this) {
    _PinsEventGet s => get(s),
  };
}

final class _PinsEventGet extends PinsEvent {
  const _PinsEventGet();
}
