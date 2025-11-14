import '../../../../authentication/data/dto/user.dart';
import '../../model/student.dart';

class StudentDto {
  const StudentDto({
    required this.id,
    required this.dormitoryId,
    required this.roomId,
    required this.user,
  });

  final int id;
  final int dormitoryId;
  final int roomId;
  final UserDto user;

  String get uid => user.uid;

  StudentEntity toEntity() => StudentEntity(
    id: id,
    buildingId: dormitoryId,
    roomId: roomId,
    user: user.toEntity(),
  );

  static StudentDto fromEntity(StudentEntity entity) => StudentDto(
    id: entity.id,
    dormitoryId: entity.buildingId,
    roomId: entity.roomId,
    user: UserDto.fromEntity(entity.user),
  );

  Map<String, Object> toJson() => {
    'id': id,
    'dormitory_id': dormitoryId,
    'room_id': roomId,
    'user': user.toJson(),
  };

  factory StudentDto.fromJson(Map<String, dynamic> json) => StudentDto(
    id: json['id'],
    dormitoryId: json['dormitory_id'],
    roomId: json['room_id'],
    user: UserDto.fromJson(json['user']),
  );

  @override
  String toString() =>
      'StudentDto('
      'id: $id, '
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId, '
      'user: $user)';
}
