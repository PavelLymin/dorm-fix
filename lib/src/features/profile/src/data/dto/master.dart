import '../../../../authentication/src/data/dto/user.dart';
import '../../../../yandex_mapkit/src/data/dto/dormitory.dart';
import '../../model/profile.dart';

class MasterDto {
  const MasterDto({
    required this.id,
    required this.user,
    required this.dormitory,
  });

  final String id;
  final UserDto user;
  final DormitoryDto dormitory;

  MasterEntity toEntity() => MasterEntity(
    id: int.parse(id),
    user: user.toEntity(),
    dormitory: dormitory.toEntity(),
  );

  factory MasterDto.fromEntity(MasterEntity entity) => MasterDto(
    id: entity.id.toString(),
    user: UserDto.fromEntity(entity.user),
    dormitory: DormitoryDto.fromEntity(entity.dormitory),
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
  };

  factory MasterDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final String id,
      'user': final Map<String, Object?> userData,
      'dormitory': final Map<String, Object?> dormitoryData,
    }) {
      return MasterDto(
        id: id,
        user: UserDto.fromJson(userData),
        dormitory: DormitoryDto.fromJson(dormitoryData),
      );
    } else {
      throw ArgumentError('Invalid JSON format for CreatedStudent: $json');
    }
  }
}
