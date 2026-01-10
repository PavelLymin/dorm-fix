part of 'profile.dart';

final class MasterEntity extends ProfileEntity {
  const MasterEntity({
    required this.id,
    required this.user,
    required this.dormitory,
  });

  final int id;
  final AuthenticatedUser user;
  final DormitoryEntity dormitory;

  String get uid => user.uid;

  MasterEntity copyWith({
    int? id,
    DormitoryEntity? dormitory,
    AuthenticatedUser? user,
  }) => MasterEntity(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
  );

  @override
  String toString() =>
      'MasterEntity('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory)';

  @override
  bool operator ==(Object other) => other is MasterEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
