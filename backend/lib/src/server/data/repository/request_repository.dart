import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../model/request.dart';
import '../dto/request.dart';

abstract interface class IRequestRepository {
  Future<void> createRequest({
    required CreatedRequestEntity request,
    required String uid,
  });
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<void> createRequest({
    required CreatedRequestEntity request,
    required String uid,
  }) async {
    final dto = CreatedRequestDto.fromEntity(request);
    await _database.transaction(() async {
      final requestId = await _database
          .into(_database.requests)
          .insert(dto.toCompanion(uid: uid));

      for (final problem in dto.imagePaths) {
        final problemCompanion = ProblemsCompanion(
          requestId: Value(requestId),
          photoPath: Value(problem),
        );
        await _database.into(_database.problems).insert(problemCompanion);
      }
    });
  }
}
