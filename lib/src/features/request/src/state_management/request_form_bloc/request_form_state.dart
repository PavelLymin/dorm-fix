part of 'request_form_bloc.dart';

typedef RequestFormStateMatch<R, S extends RequestFormState> =
    R Function(S state);

sealed class RequestFormState {
  const RequestFormState({required RequestFormModel formModel})
    : _formModel = formModel;

  final RequestFormModel _formModel;

  RequestFormModel get currentFormModel => _formModel;

  const factory RequestFormState.form({required RequestFormModel formModel}) =
      _RequestFormInititalState;

  const factory RequestFormState.error({
    required RequestFormModel formModel,
    required String message,
  }) = _RequestFormErrorState;

  R map<R>({
    required RequestFormStateMatch<R, _RequestFormInititalState> form,
    required RequestFormStateMatch<R, _RequestFormErrorState> error,
  }) => switch (this) {
    _RequestFormInititalState s => form(s),
    _RequestFormErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    RequestFormStateMatch<R, _RequestFormInititalState>? form,
    RequestFormStateMatch<R, _RequestFormErrorState>? error,
  }) => map<R>(form: form ?? (_) => orElse(), error: error ?? (_) => orElse());

  R? mapOrNull<R>({
    RequestFormStateMatch<R, _RequestFormInititalState>? form,
    RequestFormStateMatch<R, _RequestFormErrorState>? error,
  }) => map<R?>(form: form ?? (_) => null, error: error ?? (_) => null);
}

final class _RequestFormInititalState extends RequestFormState {
  const _RequestFormInititalState({required super.formModel});
}

final class _RequestFormErrorState extends RequestFormState {
  const _RequestFormErrorState({
    required super.formModel,
    required this.message,
  });

  final String message;
}
