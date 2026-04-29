import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';

import '../../../material.dart';

class MaterialTypeDto {
  const MaterialTypeDto({required this.id, required this.name});

  final int id;
  final String name;

  MaterialTypeEntity toEntity() => MaterialTypeEntity(id: id, name: name);

  factory MaterialTypeDto.fromEntity(MaterialTypeEntity entity) =>
      MaterialTypeDto(id: entity.id, name: entity.name);

  MaterialTypesCompanion toCompanion() =>
      MaterialTypesCompanion(id: Value(id), name: Value(name));

  factory MaterialTypeDto.fromData(MaterialType data) =>
      MaterialTypeDto(id: data.id, name: data.name);

  Map<String, Object?> toJson() => {'id': id, 'name': name};

  factory MaterialTypeDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'name': final String name,
    }) {
      return MaterialTypeDto(id: id, name: name);
    }

    throw ArgumentError('Invalid JSON format for MaterialTypeDto: $json');
  }
}
