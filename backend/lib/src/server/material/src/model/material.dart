import '../../material.dart';

class MaterialEntity {
  const MaterialEntity({
    required this.id,
    required this.type,
    required this.description,
    required this.photoPath,
  });

  final int id;
  final MaterialTypeEntity type;
  final String description;
  final String photoPath;

  MaterialEntity copyWith({
    int? id,
    MaterialTypeEntity? type,
    String? description,
    String? photoPath,
  }) => MaterialEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    description: description ?? this.description,
    photoPath: photoPath ?? this.photoPath,
  );

  @override
  String toString() =>
      'MaterialEntity('
      'id: $id, '
      'type: $type, '
      'description: $description, '
      'photoPath: $photoPath)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MaterialEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
