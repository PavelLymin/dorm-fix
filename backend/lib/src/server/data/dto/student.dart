import '../../model/student.dart';

class StudentDto {
  const StudentDto({
    required this.id,
    required this.buildingId,
    required this.roomId,
    required this.name,
    required this.role,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  final String id;
  final int buildingId;
  final int roomId;
  final String name;
  final String role;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  StudentEntity toEntity() => StudentEntity(
    id: id,
    buildingId: buildingId,
    roomId: roomId,
    name: name,
    role: role,
    email: email,
    phoneNumber: phoneNumber,
    photoURL: photoURL,
  );

  static StudentDto fromEntity(StudentEntity entity) => StudentDto(
    id: entity.id,
    buildingId: entity.buildingId,
    roomId: entity.roomId,
    name: entity.name,
    role: entity.role,
    email: entity.email,
    phoneNumber: entity.phoneNumber,
    photoURL: entity.photoURL,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'building_id': buildingId,
    'room_id': roomId,
    'name': name,
    'role': role,
    'email': email,
    'phone': phoneNumber,
    'photo_url': photoURL,
  };

  factory StudentDto.fromJson(Map<String, dynamic> json) => StudentDto(
    id: json['id'],
    buildingId: json['building_id'],
    roomId: json['room_id'],
    name: json['name'],
    role: json['role'],
    email: json['email'],
    phoneNumber: json['phone'],
    photoURL: json['photo_url'],
  );

  @override
  String toString() =>
      'StudentDto('
      'id: $id, '
      'buildingId: $buildingId, '
      'roomId: $roomId, '
      'name: $name, '
      'role: $role, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL)';
}
