part of 'student_bloc.dart';

typedef StudentEventMatch<R, S extends StudentEvent> = R Function(S event);

sealed class StudentEvent {
  const StudentEvent();

  factory StudentEvent.get({required String uid}) => _StudentGet(uid: uid);

  R match<R>({
    // ignore: library_private_types_in_public_api
    required StudentEventMatch<R, _StudentGet> get,
  }) => switch (this) {
    _StudentGet s => get(s),
  };
}

class _StudentGet extends StudentEvent {
  const _StudentGet({required this.uid});

  final String uid;
}
