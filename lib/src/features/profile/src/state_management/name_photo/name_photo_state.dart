part of 'name_photo_bloc.dart';

typedef NamePhotoStateMatch<R, S extends NamePhotoState> = R Function(S state);

sealed class NamePhotoState {
  const NamePhotoState();

  const factory NamePhotoState.initial() = _InitialState;

  const factory NamePhotoState.success() = _SuccessState;

  const factory NamePhotoState.loading() = _LoadingState;

  const factory NamePhotoState.error({required Object message}) = _ErrorState;

  R map<R>({
    required NamePhotoStateMatch<R, _InitialState> initial,
    required NamePhotoStateMatch<R, _SuccessState> success,
    required NamePhotoStateMatch<R, _LoadingState> loading,
    required NamePhotoStateMatch<R, _ErrorState> error,
  }) => switch (this) {
    _InitialState s => initial(s),
    _SuccessState s => success(s),
    _LoadingState s => loading(s),
    _ErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    NamePhotoStateMatch<R, _InitialState>? initial,
    NamePhotoStateMatch<R, _SuccessState>? success,
    NamePhotoStateMatch<R, _LoadingState>? loading,
    NamePhotoStateMatch<R, _ErrorState>? error,
  }) => map<R>(
    initial: initial ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    NamePhotoStateMatch<R, _InitialState>? initial,
    NamePhotoStateMatch<R, _SuccessState>? success,
    NamePhotoStateMatch<R, _LoadingState>? loading,
    NamePhotoStateMatch<R, _ErrorState>? error,
  }) => map<R?>(
    initial: initial ?? (_) => null,
    success: success ?? (_) => null,
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _InitialState extends NamePhotoState {
  const _InitialState();
}

final class _SuccessState extends NamePhotoState {
  const _SuccessState();
}

final class _LoadingState extends NamePhotoState {
  const _LoadingState();
}

final class _ErrorState extends NamePhotoState {
  const _ErrorState({required this.message});

  final Object message;
}
