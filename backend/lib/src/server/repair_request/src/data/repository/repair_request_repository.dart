import 'package:drift/drift.dart';

import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';
import '../../model/status.dart';

abstract interface class IRequestRepository {
  Future<Request> createRequest({
    required String uid,
    required int chatId,
    required PartialRepairRequest request,
  });

  Future<Request> updateStatus({
    required int requestId,
    required StatusEnum status,
  });
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({required Database database}) : _db = database;

  final Database _db;

  @override
  Future<Request> createRequest({
    required String uid,
    required int chatId,
    required PartialRepairRequest request,
  }) async {
    final dto = PartialRepairRequestDto.fromEntity(request);
    final result = await _db
        .into(_db.requests)
        .insertReturning(dto.toCompanion(uid: uid, chatId: chatId));

    return result;
  }

  @override
  Future<Request> updateStatus({
    required int requestId,
    required StatusEnum status,
  }) async {
    final result =
        await (_db.update(_db.requests)..where((t) => t.id.equals(requestId)))
            .writeReturning(
              RequestsCompanion(currentStatus: Value(status.value)),
            )
            .then((value) => value.single);

    return result;
  }
}
