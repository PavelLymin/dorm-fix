import '../../../dormitory/dormitory.dart';
import '../../../specialization/specialization.dart';
import '../../profile.dart';

final class MasterEntity {
  const MasterEntity({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.specialization,
  });

  final int id;
  final UserEntity user;
  final DormitoryEntity dormitory;
  final SpecializationEntity specialization;

  String get uid => user.uid;

  MasterEntity copyWith({
    int? id,
    UserEntity? user,
    DormitoryEntity? dormitory,
    SpecializationEntity? specialization,
  }) => MasterEntity(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
    specialization: specialization ?? this.specialization,
  );

  @override
  String toString() =>
      'MasterEntity('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory '
      'specialization: $specialization)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MasterEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
