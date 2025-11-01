import '../../model/student.dart';

class StudentDto {
  const StudentDto({
    required this.id,
    required this.dormitoryId,
    required this.roomId,
  });

  final int id;
  final int dormitoryId;
  final int roomId;

  StudentEntity toEntity() =>
      StudentEntity(id: id, buildingId: dormitoryId, roomId: roomId);

  static StudentDto fromEntity(StudentEntity entity) => StudentDto(
    id: entity.id,
    dormitoryId: entity.buildingId,
    roomId: entity.roomId,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'dormitory_id': dormitoryId,
    'room_id': roomId,
  };

  factory StudentDto.fromJson(Map<String, dynamic> json) => StudentDto(
    id: json['id'],
    dormitoryId: json['dormitory_id'],
    roomId: json['room_id'],
  );

  @override
  String toString() =>
      'StudentDto('
      'id: $id, '
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId)';
}
