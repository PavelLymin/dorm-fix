import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  // Stream<List<FullRepairRequest>> watchRequests({
  //   required int specializationId,
  // });
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

  // @override
  // Stream<List<FullRepairRequest>> watchRequests({
  //   required int specializationId,
  // }) async* {
  //   yield* (_database.select(_database.requests)
  //         ..where((row) => row.specializationId.equals(specializationId)))
  //       .map((row) => FullRepairRequestDto.fromData(row).toEntity())
  //       .watch();
  // }
}
