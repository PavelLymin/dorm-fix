class SpecializationEntity {
  const SpecializationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
  });

  final int id;
  final String title;
  final String description;
  final String photoUrl;

  SpecializationEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? photoUrl,
  }) => SpecializationEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    photoUrl: photoUrl ?? this.photoUrl,
  );

  @override
  String toString() =>
      'SpecializationEntity('
      'id: $id, '
      'title: $title, '
      'description: $description, '
      'photoUrl: $photoUrl)';

  @override
  bool operator ==(Object other) =>
      other is SpecializationEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class FakeSpecializationEntity extends SpecializationEntity {
  const FakeSpecializationEntity()
    : super(
        id: 0,
        title: 'title',
        description: 'description',
        photoUrl: 'photoUrl',
      );
}
