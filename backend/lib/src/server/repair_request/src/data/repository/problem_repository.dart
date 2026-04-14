import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IProblemRepository {
  Future<List<FullProblemDto>> createProblems({
    required List<PartialProblem> problems,
  });

  Stream<List<Problem>> watchProblems({required int requestId});
}

class ProblemRepositoryImpl implements IProblemRepository {
  const ProblemRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<List<FullProblemDto>> createProblems({
    required List<PartialProblem> problems,
  }) async {
    final list = <FullProblemDto>[];
    for (final problem in problems) {
      final dto = PartialProblemDto.fromEntity(problem);
      final data = await _database
          .into(_database.problems)
          .insertReturning(dto.toCompanion());
      final result = FullProblemDto.fromData(data);
      list.add(result);
    }

    return list;
  }

  @override
  Stream<List<Problem>> watchProblems({required int requestId}) =>
      (_database.select(
        _database.problems,
      )..where((row) => row.requestId.equals(requestId))).watch();
}
