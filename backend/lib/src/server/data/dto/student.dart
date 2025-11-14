import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/student.dart';
import 'user.dart';

class StudentDto {
  const StudentDto({
    required this.id,
    required this.uid,
    required this.dormitoryId,
    required this.roomId,
    required this.user,
  });

  final int id;
  final String uid;
  final int dormitoryId;
  final int roomId;
  final UserDto user;

  StudentEntity toEntity() => StudentEntity(
    id: id,
    buildingId: dormitoryId,
    roomId: roomId,
    user: user.toEntity(),
  );

  factory StudentDto.fromEntity(StudentEntity entity) => StudentDto(
    id: entity.id,
    uid: entity.uid,
    dormitoryId: entity.buildingId,
    roomId: entity.roomId,
    user: UserDto.fromEntity(entity.user),
  );

  StudentsCompanion toCompanion() => StudentsCompanion(
    id: Value(id),
    uid: Value(uid),
    dormitoryId: Value(dormitoryId),
    roomId: Value(roomId),
  );

  factory StudentDto.fromData(Student student, User user) => StudentDto(
    id: student.id,
    uid: student.uid,
    dormitoryId: student.dormitoryId,
    roomId: student.roomId,
    user: UserDto.fromData(user),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'dormitory_id': dormitoryId,
    'room_id': roomId,
    'user': user.toJson(),
  };

  factory StudentDto.fromJson(Map<String, dynamic> json) => StudentDto(
    id: json['id'],
    uid: json['uid'],
    dormitoryId: json['dormitory_id'],
    roomId: json['room_id'],
    user: UserDto.fromJson(json['user']),
  );

  @override
  String toString() =>
      'StudentDto('
      'id: $id, '
      'uid: $uid, '
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId, '
      'user: $user)';
}
