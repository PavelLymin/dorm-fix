part of 'button_bloc.dart';

typedef ButtonEventMatch<R, E extends ButtonEvent> =
    FutureOr<R> Function(E event);

sealed class ButtonEvent {
  const ButtonEvent();

  const factory ButtonEvent.addDisabled() = _AddDisabled;
  const factory ButtonEvent.addEnabled() = _AddEnabled;
  const factory ButtonEvent.addLoading() = _AddLoading;

  FutureOr<R> map<R>({
    required ButtonEventMatch<R, _AddDisabled> addDisabled,
    required ButtonEventMatch<R, _AddEnabled> addEnabled,
    required ButtonEventMatch<R, _AddLoading> addLoading,
  }) => switch (this) {
    _AddDisabled e => addDisabled(e),
    _AddEnabled e => addEnabled(e),
    _AddLoading e => addLoading(e),
  };
}

class _AddDisabled extends ButtonEvent {
  const _AddDisabled();
}

class _AddEnabled extends ButtonEvent {
  const _AddEnabled();
}

class _AddLoading extends ButtonEvent {
  const _AddLoading();
}
