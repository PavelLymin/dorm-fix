import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/master.dart';
import 'dormitory.dart';
import 'user.dart';

class MasterDto {
  MasterDto({required this.id, required this.user, required this.dormitory});

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
    user: UserDto.fromEntity(entity.user),
    dormitory: DormitoryDto.fromEntity(entity.dormitory),
  );

  MastersCompanion toCompanion() => MastersCompanion(
    id: Value(id),
    uid: Value(user.uid),
    dormitoryId: Value(dormitory.id),
  );

  factory MasterDto.fromData(Master master, User user, Dormitory dormitory) =>
      MasterDto(
        id: master.id,
        user: UserDto.fromData(user),
        dormitory: DormitoryDto.fromData(dormitory),
      );

  factory MasterDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'user': final Map<String, Object?> userJson,
      'dormitory': final Map<String, Object?> dormitoryJson,
    }) {
      return MasterDto(
        id: id,
        user: UserDto.fromJson(userJson),
        dormitory: DormitoryDto.fromJson(dormitoryJson),
      );
    } else {
      throw ArgumentError('Invalid JSON format for Master: $json');
    }
  }

  Map<String, Object?> toJson() => {
    'id': id,
    'user': user.toJson(),
    'dormitory': dormitory.toJson(),
  };
}
