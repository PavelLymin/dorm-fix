part of 'student_bloc.dart';

typedef StudentEventMatch<R, S extends StudentEvent> = R Function(S event);

sealed class StudentEvent {
  const StudentEvent();

  factory StudentEvent.get() => _StudentGet();

  R match<R>({
    // ignore: library_private_types_in_public_api
    required StudentEventMatch<R, _StudentGet> get,
  }) => switch (this) {
    _StudentGet s => get(s),
  };
}

class _StudentGet extends StudentEvent {
  const _StudentGet();
}
