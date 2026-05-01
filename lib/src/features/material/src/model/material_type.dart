class MaterialTypeEntity {
  const MaterialTypeEntity({required this.id, required this.name});

  final int id;
  final String name;

  MaterialTypeEntity copyWith({int? id, String? name}) =>
      MaterialTypeEntity(id: id ?? this.id, name: name ?? this.name);

  @override
  String toString() =>
      'MaterialTypeEntity('
      'id: $id, '
      'name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MaterialTypeEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
