part of 'profile_bloc.dart';

typedef ProfileEventMatch<R, E extends ProfileEvent> = R Function(E event);

sealed class ProfileEvent {
  const ProfileEvent();

  factory ProfileEvent.get() => _GetProfileEvent();

  factory ProfileEvent.updateUserProfile({required AuthenticatedUser user}) =>
      _UpdateUserProfileEvent(user: user);

  factory ProfileEvent.updateStudentProfile({
    required FullStudentEntity student,
  }) => _UpdateStudentProfileEvent(student: student);

  R map<R>({
    required ProfileEventMatch<R, _GetProfileEvent> get,
    required ProfileEventMatch<R, _UpdateUserProfileEvent> updateUserProfile,
    required ProfileEventMatch<R, _UpdateStudentProfileEvent>
    updateStudentProfile,
  }) => switch (this) {
    _GetProfileEvent e => get(e),
    _UpdateUserProfileEvent e => updateUserProfile(e),
    _UpdateStudentProfileEvent e => updateStudentProfile(e),
  };
}

final class _GetProfileEvent extends ProfileEvent {
  const _GetProfileEvent();
}

final class _UpdateUserProfileEvent extends ProfileEvent {
  const _UpdateUserProfileEvent({required this.user});

  final AuthenticatedUser user;
}

final class _UpdateStudentProfileEvent extends ProfileEvent {
  const _UpdateStudentProfileEvent({required this.student});

  final FullStudentEntity student;
}
