import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../model/instruction_step.dart';

class InstructionStepDto {
  const InstructionStepDto({
    required this.id,
    required this.instructionId,
    required this.step,
    required this.description,
    required this.isOptional,
  });

  final int id;
  final int instructionId;
  final int step;
  final String description;
  final bool isOptional;

  InstructionStepEntity toEntity() => InstructionStepEntity(
    id: id,
    instructionId: instructionId,
    step: step,
    description: description,
    isOptional: isOptional,
  );

  factory InstructionStepDto.fromEntity(InstructionStepEntity entity) =>
      InstructionStepDto(
        id: entity.id,
        instructionId: entity.instructionId,
        step: entity.step,
        description: entity.description,
        isOptional: entity.isOptional,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'instruction_id': instructionId,
    'step': step,
    'description': description,
    'is_optional': isOptional,
  };

  factory InstructionStepDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': int id,
      'instruction_id': int instructionId,
      'step': int step,
      'description': String description,
      'is_optional': bool? isOptional,
    }) {
      return InstructionStepDto(
        id: id,
        instructionId: instructionId,
        step: step,
        description: description,
        isOptional: isOptional ?? false,
      );
    }

    throw ArgumentError('Invalid JSON format for InstructionStepDto: $json');
  }

  InstructionStepsCompanion toCompanion() => InstructionStepsCompanion(
    id: Value(id),
    instructionId: Value(instructionId),
    step: Value(step),
    description: Value(description),
    isOptional: Value(isOptional),
  );

  factory InstructionStepDto.fromData(InstructionStep step) =>
      InstructionStepDto(
        id: step.id,
        instructionId: step.instructionId,
        step: step.step,
        description: step.description,
        isOptional: step.isOptional,
      );
}
