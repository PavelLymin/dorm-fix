part of 'button_bloc.dart';

typedef ButtonStateMatch<R, S extends ButtonState> = R Function(S state);

sealed class ButtonState {
  const ButtonState();

  bool get isEnabled =>
      map(disabled: (_) => false, enabled: (_) => true, loading: (_) => false);

  bool get isLoading =>
      map(disabled: (_) => false, enabled: (_) => false, loading: (_) => true);

  bool get isDisabled =>
      map(disabled: (_) => true, enabled: (_) => false, loading: (_) => false);

  const factory ButtonState.disabled() = _ButtonDisabled;
  const factory ButtonState.enabled() = _ButtonEnabled;
  const factory ButtonState.loading() = _ButtonLoading;

  R map<R>({
    required ButtonStateMatch<R, _ButtonDisabled> disabled,
    required ButtonStateMatch<R, _ButtonEnabled> enabled,
    required ButtonStateMatch<R, _ButtonLoading> loading,
  }) => switch (this) {
    _ButtonDisabled s => disabled(s),
    _ButtonEnabled s => enabled(s),
    _ButtonLoading s => loading(s),
  };

  R maybeMap<R>({
    required R Function(ButtonState) orElse,
    ButtonStateMatch<R, _ButtonDisabled>? disabled,
    ButtonStateMatch<R, _ButtonEnabled>? enabled,
    ButtonStateMatch<R, _ButtonLoading>? loading,
  }) => map<R>(
    disabled: disabled ?? (s) => orElse(s),
    enabled: enabled ?? (s) => orElse(s),
    loading: loading ?? (s) => orElse(s),
  );

  R? mapOrNull<R>({
    ButtonStateMatch<R, _ButtonDisabled>? disabled,
    ButtonStateMatch<R, _ButtonEnabled>? enabled,
    ButtonStateMatch<R, _ButtonLoading>? loading,
  }) => map<R?>(
    disabled: disabled ?? (_) => null,
    enabled: enabled ?? (_) => null,
    loading: loading ?? (_) => null,
  );
}

final class _ButtonDisabled extends ButtonState {
  const _ButtonDisabled();
}

final class _ButtonEnabled extends ButtonState {
  const _ButtonEnabled();
}

final class _ButtonLoading extends ButtonState {
  const _ButtonLoading();
}
