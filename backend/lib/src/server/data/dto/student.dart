import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/student.dart';
import 'dormitory.dart';
import 'room.dart';
import 'user.dart';

abstract class StudentDto {
  const StudentDto();

  factory StudentDto.created({
    required int dormitoryId,
    required int roomId,
    required UserDto user,
  }) => CreatedStudentDto(dormitoryId: dormitoryId, roomId: roomId, user: user);

  factory StudentDto.full({
    required int id,
    required UserDto user,
    required DormitoryDto dormitory,
    required RoomDto room,
  }) => FullStudentDto(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentEntity toEntity();

  Map<String, Object> toJson();
}

class CreatedStudentDto extends StudentDto {
  const CreatedStudentDto({
    required this.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final UserDto user;
  final int dormitoryId;
  final int roomId;

  @override
  String get uid => user.uid;

  @override
  CreatedStudentEntity toEntity() => CreatedStudentEntity(
    dormitoryId: dormitoryId,
    roomId: roomId,
    user: user.toEntity(),
  );

  factory CreatedStudentDto.fromEntity(CreatedStudentEntity entity) =>
      CreatedStudentDto(
        dormitoryId: entity.dormitoryId,
        roomId: entity.roomId,
        user: UserDto.fromEntity(entity.user),
      );

  StudentsCompanion toCompanion() => StudentsCompanion(
    uid: Value(uid),
    dormitoryId: Value(dormitoryId),
    roomId: Value(roomId),
  );

  @override
  Map<String, Object> toJson() => {
    'dormitory_id': dormitoryId,
    'room_id': roomId,
    'user': user.toJson(),
  };

  factory CreatedStudentDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'dormitory_id': final int dormitoryId,
      'room_id': final int roomId,
      'user': final Map<String, Object?> userJson,
    }) {
      return CreatedStudentDto(
        dormitoryId: dormitoryId,
        roomId: roomId,
        user: UserDto.fromJson(userJson),
      );
    } else {
      throw ArgumentError('Invalid JSON format for CreatedStudent: $json');
    }
  }
}

class FullStudentDto extends StudentDto {
  const FullStudentDto({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final UserDto user;
  final DormitoryDto dormitory;
  final RoomDto room;

  @override
  String get uid => user.uid;

  @override
  FullStudentEntity toEntity() => FullStudentEntity(
    id: id,
    user: user.toEntity(),
    dormitory: dormitory.toEntity(),
    room: room.toEntity(),
  );

  factory FullStudentDto.fromEntity(FullStudentEntity entity) => FullStudentDto(
    id: entity.id,
    user: UserDto.fromEntity(entity.user),
    dormitory: DormitoryDto.fromEntity(entity.dormitory),
    room: RoomDto.fromEntity(entity.room),
  );

  factory FullStudentDto.fromData(
    Student student,
    User user,
    Dormitory dormitory,
    Room room,
  ) => FullStudentDto(
    id: student.id,
    user: UserDto.fromData(user),
    dormitory: DormitoryDto.fromData(dormitory),
    room: RoomDto.fromData(room),
  );

  @override
  Map<String, Object> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
    'room': room.toJson(),
  };

  factory FullStudentDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> userJson,
      'dormitory': final Map<String, Object?> dormitoryJson,
      'room': final Map<String, Object?> roomJson,
    }) {
      return FullStudentDto(
        id: id,
        user: UserDto.fromJson(userJson),
        dormitory: DormitoryDto.fromJson(dormitoryJson),
        room: RoomDto.fromJson(roomJson),
      );
    } else {
      throw ArgumentError('Invalid JSON format for FullStudent: $json');
    }
  }
}
