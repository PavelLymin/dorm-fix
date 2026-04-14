import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';
import '../../model/status.dart';

class StatusDto {
  const StatusDto({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  final int id;
  final StatusEnum title;
  final DateTime createdAt;

  StatusEntity toEntity() =>
      StatusEntity(id: id, title: title, createdAt: createdAt);

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title.value,
    'created_at': createdAt.toLocal().toIso8601String(),
  };

  StatusesCompanion toCompanion() =>
      StatusesCompanion(id: Value(id), title: Value(title.value));

  factory StatusDto.fromEntity(StatusEntity entity) => StatusDto(
    id: entity.id,
    title: entity.title,
    createdAt: entity.createdAt,
  );

  factory StatusDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': final int id,
      'title': final String title,
      'created_at': final String createdAt,
    }) {
      return StatusDto(
        id: id,
        title: .fromString(title),
        createdAt: .parse(createdAt),
      );
    }

    throw ArgumentError('Invalid JSON format for StatusDto: $json');
  }

  factory StatusDto.fromData(Statuse companion) => StatusDto(
    id: companion.id,
    title: .fromString(companion.title),
    createdAt: companion.createdAt,
  );
}
