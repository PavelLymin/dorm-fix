part of 'dormitory_bloc.dart';

typedef DormitoryEventMatch<R, E extends DormitoryEvent> =
    FutureOr<R> Function(E event);

sealed class DormitoryEvent {
  const DormitoryEvent();

  factory DormitoryEvent.get() = _GetDormitoriesEvent;

  FutureOr<R> map<R>({
    required DormitoryEventMatch<R, _GetDormitoriesEvent> get,
  }) => switch (this) {
    _GetDormitoriesEvent e => get(e),
  };
}

final class _GetDormitoriesEvent extends DormitoryEvent {
  const _GetDormitoriesEvent();
}
