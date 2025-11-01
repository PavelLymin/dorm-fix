class StudentEntity {
  const StudentEntity({
    required this.id,
    required this.buildingId,
    required this.roomId,
  });

  final int id;
  final int buildingId;
  final int roomId;

  StudentEntity copyWith({
    int? id,
    String? uid,
    int? buildingId,
    int? roomId,
  }) => StudentEntity(
    id: id ?? this.id,
    buildingId: buildingId ?? this.buildingId,
    roomId: roomId ?? this.roomId,
  );

  @override
  String toString() =>
      'UserEntity('
      'id: $id, '
      'buildingId: $buildingId, '
      'roomId: $roomId)';

  @override
  bool operator ==(Object other) => other is StudentEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
