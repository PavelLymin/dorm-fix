import '../../../material.dart';

class MaterialDto {
  const MaterialDto({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.photoPath,
    required this.quantity,
  });

  final int id;
  final MaterialTypeDto type;
  final String name;
  final String description;
  final String photoPath;
  final int quantity;

  MaterialEntity toEntity() => MaterialEntity(
    id: id,
    type: type.toEntity(),
    name: name,
    description: description,
    photoPath: photoPath,
    quantity: quantity,
  );

  factory MaterialDto.fromEntity(MaterialEntity entity) => MaterialDto(
    id: entity.id,
    type: .fromEntity(entity.type),
    name: entity.name,
    description: entity.description,
    photoPath: entity.photoPath,
    quantity: entity.quantity,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'type': type.toJson(),
    'name': name,
    'description': description,
    'photo_path': photoPath,
    'quantity': quantity,
  };

  factory MaterialDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'type': final Map<String, Object?> type,
      'name': final String name,
      'description': final String description,
      'photo_path': final String photoPath,
      'quantity': final int quantity,
    }) {
      return MaterialDto(
        id: id,
        type: .fromJson(type),
        name: name,
        description: description,
        photoPath: photoPath,
        quantity: quantity,
      );
    }

    throw ArgumentError('Invalid JSON format for MaterialDto: $json');
  }
}
