part of 'user.dart';

sealed class ProfileUser extends AuthenticatedUser {
  const ProfileUser({
    required this.id,
    required this.user,
    required this.dormitory,
  });

  final int id;
  final FirebaseUser user;
  final DormitoryEntity dormitory;

  const factory ProfileUser.student({
    required int id,
    required FirebaseUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) = FullStudent;

  const factory ProfileUser.master({
    required int id,
    required FirebaseUser user,
    required SpecializationEntity specialization,
    required DormitoryEntity dormitory,
  }) = MasterUser;

  const factory ProfileUser.studentFake() = FakeStudent;
  const factory ProfileUser.masterFake() = MasterUser.fake;

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
