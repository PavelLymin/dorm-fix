import '../../../dormitory/dormitory.dart';
import '../../../room/room.dart';
import '../../profile.dart';

sealed class StudentEntity {
  const StudentEntity({required this.user});

  final UserEntity user;

  const factory StudentEntity.partial({
    required int dormitoryId,
    required int roomId,
    required UserEntity user,
  }) = PartialStudent;

  const factory StudentEntity.full({
    required int id,
    required UserEntity user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) = FullStudent;

  String get uid;

  StudentEntity copyWith();
}

final class PartialStudent extends StudentEntity {
  const PartialStudent({
    required super.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final int dormitoryId;
  final int roomId;

  @override
  String get uid => user.uid;

  @override
  PartialStudent copyWith({int? dormitoryId, int? roomId, UserEntity? user}) =>
      PartialStudent(
        dormitoryId: dormitoryId ?? this.dormitoryId,
        roomId: roomId ?? this.roomId,
        user: user ?? this.user,
      );

  @override
  String toString() =>
      'PartialStudent('
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId, '
      'user: $user)';
}

final class FullStudent extends StudentEntity {
  const FullStudent({
    required this.id,
    required super.user,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final DormitoryEntity dormitory;
  final RoomEntity room;

  @override
  String get uid => user.uid;

  @override
  FullStudent copyWith({
    int? id,
    DormitoryEntity? dormitory,
    RoomEntity? room,
    UserEntity? user,
  }) => FullStudent(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
    room: room ?? this.room,
  );

  @override
  String toString() =>
      'FullStudent('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory, '
      'room: $room)';
}
