part of 'user.dart';

sealed class ProfileUser extends AuthenticatedUser {
  const ProfileUser();

  const factory ProfileUser.student({
    required int id,
    required FirebaseUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) = FullStudent;

  const factory ProfileUser.master({
    required int id,
    required FirebaseUser user,
    required DormitoryEntity dormitory,
  }) = MasterUser;

  const factory ProfileUser.studentFake() = FakeStudent;
  const factory ProfileUser.masterFake() = MasterUser.fake;

  bool get isFake;

  R mapRoleUser<R>({
    required AuthenticatedUserMatch<R, FullStudent> student,
    required AuthenticatedUserMatch<R, MasterUser> master,
  }) => switch (this) {
    FullStudent u => student(u),
    MasterUser u => master(u),
  };

  factory ProfileUser.fromRole({
    required Role role,
    required Map<String, Object?> json,
  }) => switch (role) {
    .student => FullStudentDto.fromJson(json).toEntity(),
    .master => MasterDto.fromJson(json).toEntity(),
  };
}
