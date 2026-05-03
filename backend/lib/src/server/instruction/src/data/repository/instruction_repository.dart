import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../instruction.dart';

abstract interface class IInstructionRepository {
  Future<List<InstructionEntity>> getAllInstructions();

  Future<InstructionEntity?> getInstructionById(int id);
}

class InstructionRepositoryImpl implements IInstructionRepository {
  const InstructionRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<List<InstructionEntity>> getAllInstructions() async {
    final instructions = await _database.select(_database.instructions).get();

    final result = <InstructionEntity>[];

    for (final instruction in instructions) {
      final steps =
          await (_database.select(_database.instructionSteps)
                ..where((step) => step.instructionId.equals(instruction.id))
                ..orderBy([(step) => OrderingTerm(expression: step.step)]))
              .get();

      final dto = InstructionDto.fromData(instruction, steps);
      result.add(dto.toEntity());
    }

    return result;
  }

  @override
  Future<InstructionEntity?> getInstructionById(int id) async {
    final instruction = await (_database.select(
      _database.instructions,
    )..where((inst) => inst.id.equals(id))).getSingleOrNull();

    if (instruction == null) return null;

    final steps =
        await (_database.select(_database.instructionSteps)
              ..where((step) => step.instructionId.equals(id))
              ..orderBy([(step) => OrderingTerm(expression: step.step)]))
            .get();

    final dto = InstructionDto.fromData(instruction, steps);
    return dto.toEntity();
  }
}
