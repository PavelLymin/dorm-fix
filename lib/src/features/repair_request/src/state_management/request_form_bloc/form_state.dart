part of 'request_form_bloc.dart';

typedef FormStateMatch<R, S extends RequestFormState> = R Function(S state);

sealed class RequestFormState {
  const RequestFormState({required RequestFormModel formModel})
    : _formModel = formModel;

  final RequestFormModel _formModel;

  RequestFormModel get currentFormModel => _formModel;

  const factory RequestFormState.initial({
    required RequestFormModel formModel,
  }) = _FormInititalState;

  const factory RequestFormState.updated({
    required RequestFormModel formModel,
  }) = _FormUpdatedState;

  const factory RequestFormState.error({
    required RequestFormModel formModel,
    required String message,
  }) = _FormErrorState;

  R map<R>({
    required FormStateMatch<R, _FormInititalState> initial,
    required FormStateMatch<R, _FormUpdatedState> updated,
    required FormStateMatch<R, _FormErrorState> error,
  }) => switch (this) {
    _FormInititalState s => initial(s),
    _FormUpdatedState s => updated(s),
    _FormErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    FormStateMatch<R, _FormInititalState>? initial,
    FormStateMatch<R, _FormUpdatedState>? updated,
    FormStateMatch<R, _FormErrorState>? error,
  }) => map<R>(
    initial: initial ?? (_) => orElse(),
    updated: updated ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    FormStateMatch<R, _FormInititalState>? initial,
    FormStateMatch<R, _FormUpdatedState>? updated,
    FormStateMatch<R, _FormErrorState>? error,
  }) => map<R?>(
    initial: initial ?? (_) => null,
    updated: updated ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _FormInititalState extends RequestFormState {
  const _FormInititalState({required super.formModel});
}

final class _FormUpdatedState extends RequestFormState {
  const _FormUpdatedState({required super.formModel});
}

final class _FormErrorState extends RequestFormState {
  const _FormErrorState({required super.formModel, required this.message});

  final String message;
}
