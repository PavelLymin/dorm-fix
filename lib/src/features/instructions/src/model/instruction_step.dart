class InstructionStepEntity {
  const InstructionStepEntity({
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

  InstructionStepEntity copyWith({
    int? id,
    int? instructionId,
    int? step,
    String? description,
    bool? isOptional,
  }) => InstructionStepEntity(
    id: id ?? this.id,
    instructionId: instructionId ?? this.instructionId,
    step: step ?? this.step,
    description: description ?? this.description,
    isOptional: isOptional ?? this.isOptional,
  );

  @override
  String toString() =>
      'InstructionStepEntity('
      'id: $id, '
      'instructionId: $instructionId, '
      'step: $step, '
      'description: $description, '
      'isOptional: $isOptional)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstructionStepEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
