import '../../../home.dart';

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

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'photo_url': photoUrl,
  };

  static SpecializationDto fromJson(Map<String, Object?> json) =>
      SpecializationDto(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        photoUrl: json['photo_url'] as String,
      );
}
