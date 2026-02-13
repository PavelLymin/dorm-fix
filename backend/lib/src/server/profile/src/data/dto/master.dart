import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../../dormitory/dormitory.dart';
import '../../../../specialization/specialization.dart';
import '../../../profile.dart';

class MasterDto {
  const MasterDto({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.specialization,
  });

  final int id;
  final UserDto user;
  final DormitoryDto dormitory;
  final SpecializationDto specialization;

  MasterEntity toEntity() => MasterEntity(
    id: id,
    user: user.toEntity(),
    dormitory: dormitory.toEntity(),
    specialization: specialization.toEntity(),
  );

  factory MasterDto.fromEntity(MasterEntity entity) => MasterDto(
    id: entity.id,
    user: .fromEntity(entity.user),
    dormitory: .fromEntity(entity.dormitory),
    specialization: .fromEntity(entity.specialization),
  );

  MastersCompanion toCompanion() => MastersCompanion(
    id: Value(id),
    uid: Value(user.uid),
    dormitoryId: Value(dormitory.id),
  );

  factory MasterDto.fromData(
    Master master,
    User user,
    Dormitory dormitory,
    Specialization specialization,
  ) => MasterDto(
    id: master.id,
    user: .fromData(user),
    dormitory: .fromData(dormitory),
    specialization: .fromData(specialization),
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
    'specialization': specialization.toJson(),
  };

  factory MasterDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> user,
      'dormitory': final Map<String, Object?> dormitory,
      'specialization': final Map<String, Object?> specialization,
    }) {
      return MasterDto(
        id: id,
        user: .fromJson(user),
        dormitory: .fromJson(dormitory),
        specialization: .fromJson(specialization),
      );
    }

    throw ArgumentError('Invalid JSON format for MasterDto: $json');
  }
}
