part of 'profile.dart';

sealed class StudentEntity extends ProfileEntity {
  const StudentEntity();

  factory StudentEntity.empty() => StudentEmpty();

  factory StudentEntity.created({
    required int dormitoryId,
    required int roomId,
    required AuthenticatedUser user,
  }) => CreatedStudentEntity(
    dormitoryId: dormitoryId,
    roomId: roomId,
    user: user,
  );

  factory StudentEntity.full({
    required int id,
    required AuthenticatedUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) => FullStudentEntity(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentEntity copyWith();

  @override
  bool operator ==(Object other) => other is StudentEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

final class CreatedStudentEntity extends StudentEntity {
  const CreatedStudentEntity({
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
  CreatedStudentEntity copyWith({
    int? dormitoryId,
    int? roomId,
    AuthenticatedUser? user,
  }) => CreatedStudentEntity(
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

final class FullStudentEntity extends StudentEntity {
  const FullStudentEntity({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final AuthenticatedUser user;
  final DormitoryEntity dormitory;
  final RoomEntity room;

  @override
  String get uid => user.uid;

  @override
  FullStudentEntity copyWith({
    int? id,
    DormitoryEntity? dormitory,
    RoomEntity? room,
    AuthenticatedUser? user,
  }) => FullStudentEntity(
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
  String get uid => '';

  @override
  StudentEmpty copyWith() => const StudentEmpty();
}
