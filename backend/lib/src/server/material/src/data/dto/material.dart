import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';
import '../../../material.dart';

class MaterialDto {
  const MaterialDto({
    required this.id,
    required this.type,
    required this.description,
    required this.photoPath,
  });

  final int id;
  final MaterialTypeDto type;
  final String description;
  final String photoPath;

  MaterialEntity toEntity() => MaterialEntity(
    id: id,
    type: type.toEntity(),
    description: description,
    photoPath: photoPath,
  );

  factory MaterialDto.fromEntity(MaterialEntity entity) => MaterialDto(
    id: entity.id,
    type: .fromEntity(entity.type),
    description: entity.description,
    photoPath: entity.photoPath,
  );

  MaterialsCompanion toCompanion() => MaterialsCompanion(
    id: Value(id),
    typeId: Value(type.id),
    description: Value(description),
    photoPath: Value(photoPath),
  );

  factory MaterialDto.fromData(Material material, MaterialType type) =>
      MaterialDto(
        id: material.id,
        type: .fromData(type),
        description: material.description,
        photoPath: material.photoPath,
      );

  Map<String, Object?> toJson() => {
    'id': id,
    'type': type.toJson(),
    'description': description,
    'photo_path': photoPath,
  };

  factory MaterialDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'type': final Map<String, Object?> type,
      'description': final String description,
      'photo_path': final String photoPath,
    }) {
      return MaterialDto(
        id: id,
        type: .fromJson(type),
        description: description,
        photoPath: photoPath,
      );
    }

    throw ArgumentError('Invalid JSON format for MaterialDto: $json');
  }
}
