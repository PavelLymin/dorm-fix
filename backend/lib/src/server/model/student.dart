class StudentEntity {
  const StudentEntity({
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

  StudentEntity copyWith({
    String? id,
    int? buildingId,
    int? roomId,
    String? name,
    String? role,
    String? email,
    String? phoneNumber,
    String? photoURL,
  }) => StudentEntity(
    id: id ?? this.id,
    buildingId: buildingId ?? this.buildingId,
    roomId: roomId ?? this.roomId,
    name: name ?? this.name,
    role: role ?? this.role,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    photoURL: photoURL ?? this.photoURL,
  );

  @override
  String toString() =>
      'UserEntity('
      'id: $id, '
      'buildingId: $buildingId, '
      'roomId: $roomId, '
      'name: $name, '
      'role: $role, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoURL: $photoURL)';

  @override
  bool operator ==(Object other) => other is StudentEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
