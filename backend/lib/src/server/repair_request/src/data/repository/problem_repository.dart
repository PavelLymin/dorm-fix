import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IProblemRepository {
  Future<List<FullProblem>> createProblems({
    required List<PartialProblem> problems,
  });

  Stream<List<FullProblem>> watchProblems({required int requestId});
}

class ProblemRepositoryImpl implements IProblemRepository {
  const ProblemRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<List<FullProblem>> createProblems({
    required List<PartialProblem> problems,
  }) async {
    final resultList = <FullProblem>[];
    for (final problem in problems) {
      final dto = PartialProblemDto.fromEntity(problem);
      final data = await _database
          .into(_database.problems)
          .insertReturning(dto.toCompanion());
      final result = FullProblemDto.fromData(data).toEntity();
      resultList.add(result);
    }

    return resultList;
  }

  @override
  Stream<List<FullProblem>> watchProblems({required int requestId}) =>
      (_database.select(
        _database.problems,
      )..where((row) => row.requestId.equals(requestId))).watch().map(
        (rows) =>
            rows.map((row) => FullProblemDto.fromData(row).toEntity()).toList(),
      );
}
