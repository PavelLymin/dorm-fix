import '../../../../students/home/home.dart';
import '../../../../profile/profile.dart';
import 'user.dart';
import '../../../../dormitory/src/data/dto/dormitory.dart';

class MasterDto {
  const MasterDto({
    required this.id,
    required this.user,
    required this.specialization,
    required this.dormitory,
  });

  final int id;
  final FirebaseUserDto user;
  final SpecializationDto specialization;
  final DormitoryDto dormitory;

  MasterUser toEntity() => MasterUser(
    id: id,
    user: user.toEntity(),
    specialization: specialization.toEntity(),
    dormitory: dormitory.toEntity(),
  );

  factory MasterDto.fromEntity(MasterUser entity) => MasterDto(
    id: entity.id,
    user: .fromEntity(entity.user),
    specialization: .fromEntity(entity.specialization),
    dormitory: .fromEntity(entity.dormitory),
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
  };

  factory MasterDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> user,
      'specialization': final Map<String, Object?> specialization,
      'dormitory': final Map<String, Object?> dormitory,
    }) {
      return MasterDto(
        id: id,
        user: .fromJson(user),
        specialization: .fromJson(specialization),
        dormitory: .fromJson(dormitory),
      );
    }

    throw ArgumentError('Invalid JSON format for MasterDto: $json');
  }
}
