import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../specialization.dart';

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

  static SpecializationDto fromJson(Map<String, Object?> json) {
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
}
