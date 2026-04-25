part of 'student_bloc.dart';

typedef StudentStateMatch<R, S extends StudentState> = R Function(S state);

sealed class StudentState {
  const StudentState();

  const factory StudentState.initial() = _StudentInitial;
  const factory StudentState.loading() = _StudentLoading;
  const factory StudentState.loaded() = _StudentLoaded;
  const factory StudentState.error({required Object error}) = _StudentError;

  R map<R>({
    required StudentStateMatch<R, _StudentInitial> initial,
    required StudentStateMatch<R, _StudentLoading> loading,
    required StudentStateMatch<R, _StudentLoaded> loaded,
    required StudentStateMatch<R, _StudentError> error,
  }) => switch (this) {
    _StudentInitial s => initial(s),
    _StudentLoading s => loading(s),
    _StudentLoaded s => loaded(s),
    _StudentError s => error(s),
  };

  R maybeMap<R>({
    StudentStateMatch<R, _StudentInitial>? initial,
    StudentStateMatch<R, _StudentLoading>? loading,
    StudentStateMatch<R, _StudentLoaded>? loaded,
    StudentStateMatch<R, _StudentError>? error,
    required R Function() orElse,
  }) => map<R>(
    initial: initial ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    StudentStateMatch<R, _StudentInitial>? initial,
    StudentStateMatch<R, _StudentLoading>? loading,
    StudentStateMatch<R, _StudentLoaded>? loaded,
    StudentStateMatch<R, _StudentError>? error,
  }) => map<R?>(
    initial: initial ?? (_) => null,
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _StudentInitial extends StudentState {
  const _StudentInitial();
}

final class _StudentLoading extends StudentState {
  const _StudentLoading();
}

final class _StudentLoaded extends StudentState {
  const _StudentLoaded();
}

final class _StudentError extends StudentState {
  const _StudentError({required this.error});

  final Object error;
}
