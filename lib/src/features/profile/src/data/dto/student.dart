import '../../../../authentication/src/data/dto/user.dart';
import '../../../../room/src/data/dto/room.dart';
import '../../../../dormitory/src/data/dto/dormitory.dart';
import '../../model/profile.dart';

abstract class StudentDto {
  const StudentDto();

  factory StudentDto.partial({
    required int dormitoryId,
    required int roomId,
    required UserDto user,
  }) => PartialStudentDto(dormitoryId: dormitoryId, roomId: roomId, user: user);

  factory StudentDto.full({
    required int id,
    required UserDto user,
    required DormitoryDto dormitory,
    required RoomDto room,
  }) => FullStudentDto(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentEntity toEntity();
  Map<String, Object> toJson();

  factory StudentDto.fromEntity(StudentEntity entity) => switch (entity) {
    PartialStudent student => PartialStudentDto(
      user: .fromEntity(student.user),
      dormitoryId: student.dormitoryId,
      roomId: student.roomId,
    ),
    FullStudent student => FullStudentDto(
      id: student.id,
      user: .fromEntity(student.user),
      dormitory: .fromEntity(student.dormitory),
      room: .fromEntity(student.room),
    ),
    _ => throw UnsupportedError(
      'Unsupported student type: ${entity.runtimeType}',
    ),
  };

  factory StudentDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> user,
      'dormitory': final Map<String, Object?> dormitory,
      'room': final Map<String, Object?> room,
    }) {
      return FullStudentDto(
        id: id,
        user: UserDto.fromJson(user),
        dormitory: DormitoryDto.fromJson(dormitory),
        room: RoomDto.fromJson(room),
      );
    } else if (json case <String, Object?>{
      'dormitory_id': final int dormitoryId,
      'room_id': final int roomId,
      'user': final Map<String, Object?> user,
    }) {
      return PartialStudentDto(
        dormitoryId: dormitoryId,
        roomId: roomId,
        user: .fromJson(user),
      );
    }

    throw FormatException('Invalid JSON format for StudentDto', json);
  }
}

class PartialStudentDto extends StudentDto {
  const PartialStudentDto({
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
  PartialStudent toEntity() => PartialStudent(
    dormitoryId: dormitoryId,
    roomId: roomId,
    user: user.toEntity(),
  );

  @override
  Map<String, Object> toJson() => {
    'dormitory_id': dormitoryId,
    'room_id': roomId,
    'user': user.toJson(),
  };
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
  FullStudent toEntity() => FullStudent(
    id: id,
    user: user.toEntity(),
    dormitory: dormitory.toEntity(),
    room: room.toEntity(),
  );

  @override
  Map<String, Object> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
    'room': room.toJson(),
  };
}
