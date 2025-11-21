import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
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

  SpecializationsCompanion toCompanion() => SpecializationsCompanion(
    id: Value(id),
    title: Value(title),
    description: Value(description),
    photoUrl: Value(photoUrl),
  );

  factory SpecializationDto.fromData(Specialization specialization) =>
      SpecializationDto(
        id: specialization.id,
        title: specialization.title,
        description: specialization.description,
        photoUrl: specialization.photoUrl,
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
