import '../../../../authentication/src/data/dto/user.dart';
import '../../../../dormitory/src/data/dto/dormitory.dart';
import '../../model/profile.dart';

class MasterDto {
  const MasterDto({
    required this.id,
    required this.user,
    required this.dormitory,
  });

  final int id;
  final UserDto user;
  final DormitoryDto dormitory;

  MasterEntity toEntity() => MasterEntity(
    id: id,
    user: user.toEntity(),
    dormitory: dormitory.toEntity(),
  );

  factory MasterDto.fromEntity(MasterEntity entity) => MasterDto(
    id: entity.id,
    user: .fromEntity(entity.user),
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
      'dormitory': final Map<String, Object?> dormitory,
    }) {
      return MasterDto(
        id: id,
        user: .fromJson(user),
        dormitory: .fromJson(dormitory),
      );
    } else {
      throw ArgumentError('Invalid JSON format for MasterDto: $json');
    }
  }
}
