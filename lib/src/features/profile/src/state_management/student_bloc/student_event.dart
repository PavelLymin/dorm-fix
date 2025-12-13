part of 'student_bloc.dart';

typedef StudentEventMatch<R, E extends StudentEvent> = R Function(E event);

sealed class StudentEvent {
  const StudentEvent();

  const factory StudentEvent.create({required CreatedStudentEntity student}) =
      _StudentCreateStudent;

  R map<R>({
    // ignore: library_private_types_in_public_api
    required StudentEventMatch<R, _StudentCreateStudent> create,
  }) => switch (this) {
    _StudentCreateStudent s => create(s),
  };
}

class _StudentCreateStudent extends StudentEvent {
  const _StudentCreateStudent({required this.student});
  final CreatedStudentEntity student;
}
