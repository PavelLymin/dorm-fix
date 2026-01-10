import '../../../dormitory/dormitory.dart';
import '../../profile.dart';

final class MasterEntity {
  const MasterEntity({
    required this.id,
    required this.user,
    required this.dormitory,
  });

  final int id;
  final UserEntity user;
  final DormitoryEntity dormitory;

  String get uid => user.uid;

  MasterEntity copyWith({
    int? id,
    DormitoryEntity? dormitory,
    UserEntity? user,
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MasterEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
