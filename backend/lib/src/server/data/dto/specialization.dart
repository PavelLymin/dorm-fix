import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/specialization.dart';

class SpecializationDto {
  const SpecializationDto({
    required this.id,
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  SpecializationEntity toEntity() =>
      SpecializationEntity(id: id, name: name, description: description);

  static SpecializationDto fromEntity(SpecializationEntity entity) =>
      SpecializationDto(
        id: entity.id,
        name: entity.name,
        description: entity.description,
      );

  SpecializationsCompanion toCompanion() => SpecializationsCompanion(
    id: Value(id),
    name: Value(name),
    description: Value(description),
  );

  factory SpecializationDto.fromData(Specialization specialization) =>
      SpecializationDto(
        id: specialization.id,
        name: specialization.name,
        description: specialization.description,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };

  static SpecializationDto fromJson(Map<String, dynamic> json) =>
      SpecializationDto(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  @override
  String toString() {
    return 'SpeciaizationDto('
        'id: $id, '
        'name: $name, '
        'description: $description)';
  }

  @override
  bool operator ==(Object other) =>
      other is SpecializationDto && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
