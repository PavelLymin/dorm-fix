import '../../model/specialization.dart';

class SpecializationDto {
  const SpecializationDto({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
  });

  final int id;
  final String title;
  final String description;
  final String photoUrl;

  SpecializationEntity toEntity() => SpecializationEntity(
    id: id,
    title: title,
    description: description,
    photoUrl: photoUrl,
  );

  static SpecializationDto fromEntity(SpecializationEntity entity) =>
      SpecializationDto(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        photoUrl: entity.photoUrl,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'photo_url': photoUrl,
  };

  static SpecializationDto fromJson(Map<String, dynamic> json) =>
      SpecializationDto(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        photoUrl: json['photo_url'],
      );

  @override
  String toString() {
    return 'SpeciaizationDto('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) =>
      other is SpecializationDto && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
