part of 'student_bloc.dart';

typedef StudentEventMatch<R, E extends StudentEvent> =
    FutureOr<R> Function(E event);

sealed class StudentEvent {
  const StudentEvent();

  const factory StudentEvent.add({required PartialStudent student}) =
      _AddStudentEvent;

  FutureOr<R> map<R>({required StudentEventMatch<R, _AddStudentEvent> add}) =>
      switch (this) {
        _AddStudentEvent e => add(e),
      };
}

final class _AddStudentEvent extends StudentEvent {
  const _AddStudentEvent({required this.student});

  final PartialStudent student;
}
