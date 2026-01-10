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

  factory SpecializationDto.fromEntity(SpecializationEntity entity) =>
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

  factory SpecializationDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'title': final String title,
      'description': final String description,
      'photo_url': final String photoUrl,
    }) {
      return SpecializationDto(
        id: id,
        title: title,
        description: description,
        photoUrl: photoUrl,
      );
    } else {
      throw ArgumentError('Invalid JSON format for SpecializationDto: $json');
    }
  }
}
