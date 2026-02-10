part of 'profile.dart';

sealed class StudentEntity extends ProfileEntity {
  const StudentEntity();

  factory StudentEntity.empty() => StudentEmpty();

  factory StudentEntity.partial({
    required int dormitoryId,
    required int roomId,
    required AuthenticatedUser user,
  }) => PartialStudent(dormitoryId: dormitoryId, roomId: roomId, user: user);

  factory StudentEntity.full({
    required int id,
    required AuthenticatedUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) => FullStudent(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentEntity copyWith();
}

final class PartialStudent extends StudentEntity {
  const PartialStudent({
    required this.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final AuthenticatedUser user;
  final int dormitoryId;
  final int roomId;

  @override
  String get uid => user.uid;

  @override
  PartialStudent copyWith({
    int? dormitoryId,
    int? roomId,
    AuthenticatedUser? user,
  }) => PartialStudent(
    dormitoryId: dormitoryId ?? this.dormitoryId,
    roomId: roomId ?? this.roomId,
    user: user ?? this.user,
  );

  @override
  String toString() =>
      'UserEntity('
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId, '
      'user: $user)';
}

final class FullStudent extends StudentEntity {
  const FullStudent({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final AuthenticatedUser user;
  final DormitoryEntity dormitory;
  final RoomEntity room;

  R fullOrFake<R>({
    required R Function(FullStudent) full,
    required R Function(FakeFullStudent) fake,
  }) => full(this);

  @override
  String get uid => user.uid;

  @override
  FullStudent copyWith({
    int? id,
    DormitoryEntity? dormitory,
    RoomEntity? room,
    AuthenticatedUser? user,
  }) => FullStudent(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
    room: room ?? this.room,
  );

  @override
  String toString() =>
      'UserEntity('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory, '
      'room: $room)';
}

class StudentEmpty extends StudentEntity {
  const StudentEmpty();

  @override
  StudentEntity copyWith() => this;

  @override
  String get uid => '';
}

final class FakeFullStudent extends FullStudent {
  const FakeFullStudent()
    : super(
        id: 1,
        user: const FakeAuthenticatedUser(),
        dormitory: const FakeDormitoryEntity(),
        room: const FakeRoomEntity(),
      );

  @override
  R fullOrFake<R>({
    required R Function(FullStudent) full,
    required R Function(FakeFullStudent) fake,
  }) => fake(this);
}
