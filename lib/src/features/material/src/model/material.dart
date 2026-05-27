import '../../material.dart';

class MaterialEntity {
  const MaterialEntity({
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

  bool canSubtract(int amountToSubtract) {
    if (amountToSubtract <= 0) return false;
    return (quantity - amountToSubtract) >= 0;
  }

  MaterialEntity copyWith({
    int? id,
    MaterialTypeEntity? type,
    String? name,
    String? description,
    String? photoPath,
  }) => MaterialEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    description: description ?? this.description,
    photoPath: photoPath ?? this.photoPath,
    quantity: quantity,
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

class MaterialDraft {
  const MaterialDraft({required this.material, required this.selectedAmount});

  final MaterialEntity material;
  final int selectedAmount;

  MaterialDraft updatedAmount(int newAmount) {
    if (newAmount < 0) newAmount = 0;
    if (newAmount > material.quantity) {
      newAmount = material.quantity;
    }

    return MaterialDraft(material: material, selectedAmount: newAmount);
  }
}
