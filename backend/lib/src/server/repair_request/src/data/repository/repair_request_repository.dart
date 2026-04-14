import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<Request> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  // Stream<List<FullRepairRequest>> watchRequests({
  //   int page = 1,
  //   int limit = 10,
  //   String? uid,
  //   int? specId,
  //   int? dormId,
  //   String? status,
  // });

  // Stream<FullRepairRequest> watchRequest({required int id});
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({required Database database}) : _db = database;

  final Database _db;

  @override
  Future<Request> createRequest({
    required String uid,
    required PartialRepairRequest request,
  }) async {
    final dto = PartialRepairRequestDto.fromEntity(request);
    final result = await _db
        .into(_db.requests)
        .insertReturning(dto.toCompanion(uid: uid));

    return result;
  }

  // @override
  // Stream<List<FullRepairRequest>> watchRequests({
  //   int page = 1,
  //   int limit = 10,
  //   String? uid,
  //   int? specId,
  //   int? dormId,
  //   String? status,
  // }) {
  //   final query = _db.select(_db.requests).join([
  //     if (dormId != null)
  //       innerJoin(
  //         _db.students,
  //         _db.students.uid.equalsExp(_db.requests.uid) &
  //             _db.students.dormitoryId.equals(dormId),
  //       ),
  //   ])..limit(limit, offset: (page - 1) * limit);

  //   if (uid != null) query.where(_db.requests.uid.equals(uid));
  //   if (specId != null) query.where(_db.requests.specId.equals(specId));
  //   if (status != null) query.where(_db.requests.status.equals(status));
  //   return query.watch().map(
  //     (rows) => rows.map((row) {
  //       final request = row.readTable(_db.requests);
  //       return FullRepairRequestDto.fromData(request).toEntity();
  //     }).toList(),
  //   );
  // }

  // Stream<List<FullRepairRequest>> watchRequests2({
  //   int page = 1,
  //   int limit = 10,
  //   String? uid,
  //   int? specId,
  //   int? dormId,
  //   String? status,
  // }) {
  //   final query = _db.select(_db.requests).join([
  //     innerJoin(_db.users, _db.users.uid.equalsExp(_db.students.uid)),
  //     innerJoin(
  //       _db.dormitories,
  //       _db.dormitories.id.equalsExp(_db.students.dormitoryId),
  //     ),
  //     innerJoin(_db.rooms, _db.rooms.id.equalsExp(_db.students.roomId)),
  //   ])..limit(limit, offset: (page - 1) * limit);

  //   if (uid != null) query.where(_db.requests.uid.equals(uid));
  //   if (specId != null) query.where(_db.requests.specId.equals(specId));
  //   if (status != null) query.where(_db.requests.status.equals(status));
  //   return query.watch().map(
  //     (rows) => rows.map((row) {
  //       final request = row.readTable(_db.requests);
  //       return FullRepairRequestDto.fromData(request).toEntity();
  //     }).toList(),
  //   );
  // }

  // @override
  // Stream<FullRepairRequest> watchRequest({required int id}) =>
  //     (_db.select(_db.requests)..where((row) => row.id.equals(id)))
  //         .watchSingle()
  //         .map((row) => FullRepairRequestDto.fromData(row).toEntity());
}
