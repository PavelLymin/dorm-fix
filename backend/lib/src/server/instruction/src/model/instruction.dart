import 'instruction_step.dart';

class InstructionEntity {
  const InstructionEntity({
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
  final List<InstructionStepEntity> steps;

  InstructionEntity copyWith({
    int? id,
    String? title,
    String? complexity,
    int? durationMinutes,
    String? photoPath,
    List<InstructionStepEntity>? steps,
  }) => InstructionEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    complexity: complexity ?? this.complexity,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    photoPath: photoPath ?? this.photoPath,
    steps: steps ?? this.steps,
  );

  @override
  String toString() =>
      'InstructionEntity('
      'id: $id, '
      'title: $title, '
      'complexity: $complexity, '
      'durationMinutes: $durationMinutes, '
      'photoPath: $photoPath, '
      'steps: $steps)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InstructionEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
