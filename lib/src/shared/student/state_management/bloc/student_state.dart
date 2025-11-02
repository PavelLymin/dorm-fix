part of 'student_bloc.dart';

typedef StudentStateMatch<R, S extends StudentState> = R Function(S state);

sealed class StudentState {
  const StudentState({this.student});

  final StudentEntity? student;

  const factory StudentState.loading({StudentEntity? student}) =
      _StudentLoading;
  const factory StudentState.loaded({required StudentEntity student}) =
      _StudentLoaded;
  const factory StudentState.error({
    StudentEntity? student,
    required String message,
  }) = _StudentError;

  bool get isLoading => maybeMap(orElse: () => false, loading: (_) => true);

  R map<R>({
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentLoading> loading,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentLoaded> loaded,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentError> error,
  }) => switch (this) {
    _StudentLoading s => loading(s),
    _StudentLoaded s => loaded(s),
    _StudentError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoading>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoaded>? loaded,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoading>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoaded>? loaded,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _StudentLoading extends StudentState {
  const _StudentLoading({super.student});
}

final class _StudentLoaded extends StudentState {
  const _StudentLoaded({required super.student});
}

final class _StudentError extends StudentState {
  const _StudentError({super.student, required this.message});

  final String message;
}
