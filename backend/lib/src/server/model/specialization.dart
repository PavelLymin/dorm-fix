class SpecializationEntity {
  const SpecializationEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  SpecializationEntity copyWith({int? id, String? name, String? description}) =>
      SpecializationEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  @override
  String toString() =>
      'SpecializationEntity('
      'id: $id, '
      'name: $name, '
      'description: $description)';

  @override
  bool operator ==(Object other) =>
      other is SpecializationEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
