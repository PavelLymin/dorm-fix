import '../../../features/authentication/model/user.dart';

class StudentEntity {
  const StudentEntity({
    required this.id,
    required this.buildingId,
    required this.roomId,
    required this.user,
  });

  final int id;
  final int buildingId;
  final int roomId;
  final AuthenticatedUser user;

  StudentEntity copyWith({
    int? id,
    String? uid,
    int? buildingId,
    int? roomId,
    AuthenticatedUser? user,
  }) => StudentEntity(
    id: id ?? this.id,
    buildingId: buildingId ?? this.buildingId,
    roomId: roomId ?? this.roomId,
    user: user ?? this.user,
  );

  @override
  String toString() =>
      'UserEntity('
      'id: $id, '
      'buildingId: $buildingId, '
      'roomId: $roomId, '
      'user: $user)';

  @override
  bool operator ==(Object other) => other is StudentEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
