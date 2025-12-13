part of 'student_bloc.dart';

typedef StudentStateMatch<R, S extends StudentState> = R Function(S state);

sealed class StudentState {
  const StudentState();

  const factory StudentState.loading() = _StudentLoading;
  const factory StudentState.created() = _StudentCreatedStudent;
  const factory StudentState.error({required String message}) = _StudentError;

  R map<R>({
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentLoading> loading,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentCreatedStudent> created,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentError> error,
  }) => switch (this) {
    _StudentLoading s => loading(s),
    _StudentCreatedStudent s => created(s),
    _StudentError s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoading>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentCreatedStudent>? created,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentError>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    created: created ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoading>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentCreatedStudent>? created,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    created: created ?? (_) => null,
    error: error ?? (_) => null,
  );
}

class _StudentLoading extends StudentState {
  const _StudentLoading();
}

class _StudentCreatedStudent extends StudentState {
  const _StudentCreatedStudent();
}

class _StudentError extends StudentState {
  const _StudentError({required this.message});
  final String message;
}
