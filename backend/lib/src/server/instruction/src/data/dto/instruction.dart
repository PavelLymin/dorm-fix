import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';
import '../../model/instruction.dart';
import 'instruction_step.dart';

class InstructionDto {
  const InstructionDto({
    required this.id,
    required this.title,
    required this.complexity,
    required this.durationMinutes,
    required this.photoPath,
    required this.steps,
  });

  final int id;
  final String title;
  final String complexity;
  final int durationMinutes;
  final String photoPath;
  final List<InstructionStepDto> steps;

  InstructionEntity toEntity() => InstructionEntity(
    id: id,
    title: title,
    complexity: complexity,
    durationMinutes: durationMinutes,
    photoPath: photoPath,
    steps: steps.map((e) => e.toEntity()).toList(),
  );

  factory InstructionDto.fromEntity(InstructionEntity entity) => InstructionDto(
    id: entity.id,
    title: entity.title,
    complexity: entity.complexity,
    durationMinutes: entity.durationMinutes,
    photoPath: entity.photoPath,
    steps: entity.steps.map(InstructionStepDto.fromEntity).toList(),
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'complexity': complexity,
    'duration_minutes': durationMinutes,
    'photo_path': photoPath,
    'steps': steps.map((e) => e.toJson()).toList(),
  };

  factory InstructionDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': int id,
      'title': String title,
      'complexity': String complexity,
      'duration_minutes': int durationMinutes,
      'photo_path': String photoPath,
      'steps': List<Object> steps,
    }) {
      return InstructionDto(
        id: id,
        title: title,
        complexity: complexity,
        durationMinutes: durationMinutes,
        photoPath: photoPath,
        steps: steps
            .whereType<Map<String, Object?>>()
            .map(InstructionStepDto.fromJson)
            .toList(),
      );
    }

    throw ArgumentError('Invalid JSON format for InstructionDto: $json');
  }

  InstructionsCompanion toCompanion() => InstructionsCompanion(
    id: Value(id),
    title: Value(title),
    complexity: Value(complexity),
    durationMinutes: Value(durationMinutes),
    photoPath: Value(photoPath),
  );

  factory InstructionDto.fromData(
    Instruction instruction,
    List<InstructionStep> steps,
  ) => InstructionDto(
    id: instruction.id,
    title: instruction.title,
    complexity: instruction.complexity,
    durationMinutes: instruction.durationMinutes,
    photoPath: instruction.photoPath,
    steps: steps.map(InstructionStepDto.fromData).toList(),
  );
}
