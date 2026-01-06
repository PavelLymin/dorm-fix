part of 'request_form_bloc.dart';

typedef FormStateMatch<R, S extends RequestFormState> = R Function(S state);

sealed class RequestFormState {
  const RequestFormState({required RequestFormModel formModel})
    : _formModel = formModel;

  final RequestFormModel _formModel;

  RequestFormModel get currentFormModel => _formModel;

  const factory RequestFormState.form({required RequestFormModel formModel}) =
      _FormInititalState;

  const factory RequestFormState.error({
    required RequestFormModel formModel,
    required String message,
  }) = _FormErrorState;

  R map<R>({
    required FormStateMatch<R, _FormInititalState> form,
    required FormStateMatch<R, _FormErrorState> error,
  }) => switch (this) {
    _FormInititalState s => form(s),
    _FormErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    FormStateMatch<R, _FormInititalState>? form,
    FormStateMatch<R, _FormErrorState>? error,
  }) => map<R>(form: form ?? (_) => orElse(), error: error ?? (_) => orElse());

  R? mapOrNull<R>({
    FormStateMatch<R, _FormInititalState>? form,
    FormStateMatch<R, _FormErrorState>? error,
  }) => map<R?>(form: form ?? (_) => null, error: error ?? (_) => null);
}

final class _FormInititalState extends RequestFormState {
  const _FormInititalState({required super.formModel});
}

final class _FormErrorState extends RequestFormState {
  const _FormErrorState({required super.formModel, required this.message});

  final String message;
}
