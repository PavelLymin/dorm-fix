part of 'student_bloc.dart';

typedef StudentStateMatch<R, S extends StudentState> = R Function(S state);

sealed class StudentState {
  const StudentState({this.student});

  final StudentEntity? student;

  const factory StudentState.loading({StudentEntity? student}) =
      _StudentLoadingState;

  const factory StudentState.loaded({required StudentEntity student}) =
      _StudentLoadedState;

  const factory StudentState.error({
    StudentEntity? student,
    required String message,
  }) = _StudentErrorState;

  bool get isLoading => maybeMap(orElse: () => false, loading: (_) => true);

  R map<R>({
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentLoadingState> loading,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentLoadedState> loaded,
    // ignore: library_private_types_in_public_api
    required StudentStateMatch<R, _StudentErrorState> error,
  }) => switch (this) {
    _StudentLoadingState s => loading(s),
    _StudentLoadedState s => loaded(s),
    _StudentErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoadingState>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoadedState>? loaded,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentErrorState>? error,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoadingState>? loading,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentLoadedState>? loaded,
    // ignore: library_private_types_in_public_api
    StudentStateMatch<R, _StudentErrorState>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _StudentLoadingState extends StudentState {
  const _StudentLoadingState({super.student});
}

final class _StudentLoadedState extends StudentState {
  const _StudentLoadedState({required this.student}) : super(student: student);

  @override
  // ignore: overridden_fields
  final StudentEntity student;
}

final class _StudentErrorState extends StudentState {
  const _StudentErrorState({super.student, required this.message});

  final String message;
}
