import '../../../authentication.dart';
import '../../../../dormitory/dormitory.dart';
import '../../../../room/room.dart';

abstract class StudentDto {
  const StudentDto();

  factory StudentDto.partial({
    required int dormitoryId,
    required int roomId,
    required FirebaseUserDto user,
  }) => PartialStudentDto(dormitoryId: dormitoryId, roomId: roomId, user: user);

  factory StudentDto.full({
    required int id,
    required FirebaseUserDto user,
    required DormitoryDto dormitory,
    required RoomDto room,
  }) => FullStudentDto(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentUser toEntity();
  Map<String, Object> toJson();
}

class PartialStudentDto extends StudentDto {
  const PartialStudentDto({
    required this.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final FirebaseUserDto user;
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

  factory PartialStudentDto.fromEntity(PartialStudent entity) =>
      PartialStudentDto(
        user: .fromEntity(entity.user),
        dormitoryId: entity.dormitoryId,
        roomId: entity.roomId,
      );

  factory PartialStudentDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
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

    throw FormatException('Invalid JSON format for PartialStudentDto', json);
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
  final FirebaseUserDto user;
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

  factory FullStudentDto.fromEntity(FullStudent entity) => FullStudentDto(
    id: entity.id,
    user: .fromEntity(entity.user),
    dormitory: .fromEntity(entity.dormitory),
    room: .fromEntity(entity.room),
  );

  factory FullStudentDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> user,
      'dormitory': final Map<String, Object?> dormitory,
      'room': final Map<String, Object?> room,
    }) {
      return FullStudentDto(
        id: id,
        user: .fromJson(user),
        dormitory: DormitoryDto.fromJson(dormitory),
        room: RoomDto.fromJson(room),
      );
    }

    throw FormatException('Invalid JSON format for FullStudentDto', json);
  }
}
