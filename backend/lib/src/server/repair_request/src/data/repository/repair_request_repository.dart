import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  Stream<List<FullRepairRequest>> watchRequests({
    String? uid,
    int? specId,
    int? dormId,
    String? status,
  });

  Stream<FullRepairRequest> watchRequest({required int id});
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest request,
  }) async {
    final dto = PartialRepairRequestDto.fromEntity(request);
    final requestData = await _database
        .into(_database.requests)
        .insertReturning(dto.toCompanion(uid: uid));

    final result = FullRepairRequestDto.fromData(requestData).toEntity();

    return result;
  }

  @override
  Stream<List<FullRepairRequest>> watchRequests({
    String? uid,
    int? specId,
    int? dormId,
    String? status,
  }) {
    final query = _database.select(_database.requests).join([
      if (dormId != null)
        innerJoin(
          _database.students,
          _database.students.uid.equalsExp(_database.requests.uid) &
              _database.students.dormitoryId.equals(dormId),
        ),
    ]);
    if (uid != null) query.where(_database.requests.uid.equals(uid));
    if (specId != null) query.where(_database.requests.specId.equals(specId));
    if (status != null) query.where(_database.requests.status.equals(status));
    return query.watch().map(
      (rows) => rows.map((row) {
        final request = row.readTable(_database.requests);
        return FullRepairRequestDto.fromData(request).toEntity();
      }).toList(),
    );
  }

  @override
  Stream<FullRepairRequest> watchRequest({required int id}) =>
      (_database.select(_database.requests)..where((row) => row.id.equals(id)))
          .watchSingle()
          .map((row) => FullRepairRequestDto.fromData(row).toEntity());
}
