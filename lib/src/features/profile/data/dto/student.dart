import '../../../authentication/data/dto/user.dart';
import '../../../room/data/dto/room.dart';
import '../../../yandex_mapkit/data/dto/dormitory.dart';
import '../../model/profile.dart';

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

  @override
  Map<String, Object> toJson() => {
    'dormitory_id': dormitoryId,
    'room_id': roomId,
    'user': user.toJson(),
  };

  factory CreatedStudentDto.fromJson(Map<String, Object?> json) =>
      CreatedStudentDto(
        dormitoryId: json['dormitory_id'] as int,
        roomId: json['room_id'] as int,
        user: UserDto.fromJson(json['user'] as Map<String, Object?>),
      );
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

  @override
  Map<String, Object> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
    'room': room.toJson(),
  };

  factory FullStudentDto.fromJson(Map<String, Object?> json) => FullStudentDto(
    id: json['id'] as int,
    user: UserDto.fromJson(json['user'] as Map<String, Object?>),
    dormitory: DormitoryDto.fromJson(json['dormitory'] as Map<String, Object?>),
    room: RoomDto.fromJson(json['room'] as Map<String, Object?>),
  );
}
