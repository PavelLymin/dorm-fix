import '../../material.dart';

class MaterialEntity {
  MaterialEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.photoPath,
    required this.quantity,
  });

  final int id;
  final MaterialTypeEntity type;
  final String name;
  final String description;
  final String photoPath;
  final int quantity;

  MaterialEntity copyWith({
    int? id,
    MaterialTypeEntity? type,
    String? name,
    String? description,
    String? photoPath,
    int? quantity,
  }) => MaterialEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    description: description ?? this.description,
    photoPath: photoPath ?? this.photoPath,
    quantity: quantity ?? this.quantity,
  );

  @override
  String toString() =>
      'MaterialEntity('
      'id: $id, '
      'type: $type, '
      'name: $name, '
      'description: $description, '
      'photoPath: $photoPath, '
      'quantity: $quantity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MaterialEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
