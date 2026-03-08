import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  Stream<List<FullRepairRequest>> watchRequests({required String uid});

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
  Stream<List<FullRepairRequest>> watchRequests({required String uid}) =>
      (_database.select(
        _database.requests,
      )..where((row) => row.uid.equals(uid))).watch().map(
        (rows) => rows
            .map((row) => FullRepairRequestDto.fromData(row).toEntity())
            .toList(),
      );

  @override
  Stream<FullRepairRequest> watchRequest({required int id}) =>
      (_database.select(_database.requests)..where((row) => row.id.equals(id)))
          .watchSingle()
          .map((row) => FullRepairRequestDto.fromData(row).toEntity());
}
