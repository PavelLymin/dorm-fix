import '../../model/student.dart';

class StudentDTO {
  const StudentDTO({
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

  static StudentDTO fromEntity(StudentEntity entity) => StudentDTO(
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

  factory StudentDTO.fromJson(Map<String, dynamic> json) => StudentDTO(
    id: json['id'],
    buildingId: json['building_id'],
    roomId: json['room_id'],
    name: json['name'],
    role: json['role'],
    email: json['email'],
    phoneNumber: json['phone'],
    photoURL: json['photo_url'],
  );
}
