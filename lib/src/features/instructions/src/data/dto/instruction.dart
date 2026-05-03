import '../../../instructions.dart';

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'complexity': complexity,
    'durationMinutes': durationMinutes,
    'photoPath': photoPath,
    'steps': steps.map((e) => e.toJson()).toList(),
  };

  factory InstructionDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'id': int id,
      'title': String title,
      'complexity': String complexity,
      'duration_minutes': int durationMinutes,
      'photo_path': String photoPath,
      'steps': List<Object?> steps,
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
}
