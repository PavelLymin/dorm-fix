import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  Future<List<FullRepairRequest>> getRequests({required String uid});

  Future<FullRepairRequest?> getRequest({required int id});
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
    late final Request requestData;
    final problems = <Problem>[];
    await _database.transaction(() async {
      requestData = await _database
          .into(_database.requests)
          .insertReturning(dto.toCompanion(uid: uid));
      for (final problem in dto.problems) {
        final data = await _database
            .into(_database.problems)
            .insertReturning(problem.toCompanion());
        problems.add(data);
      }
    });
    final specialization = await (_database.select(
      _database.specializations,
    )..where((row) => row.id.equals(dto.specializationId))).getSingle();

    final fullRequest = FullRepairRequestDto.fromData(
      requestData,
      specialization,
      problems,
    ).toEntity();
    return fullRequest;
  }

  @override
  Future<List<FullRepairRequest>> getRequests({required String uid}) async {
    final result = await _database
        .customSelect(
          '''SELECT 
          r.*,
          json_object(
            'id', s.id,
            'title', s.title,
            'description', s.description,
            'photo_url', s.photo_url
          ) AS specialization,
          COALESCE(
            json_group_array(
              json_object(
                'id', p.id,
                'request_id', p.request_id,
                'photo_path', p.photo_path
              )
            ) FILTER (WHERE p.id IS NOT NULL),
            '[]'
          ) AS problems
          FROM requests r
          INNER JOIN specializations s ON s.id = r.specialization_id
          LEFT JOIN problems p ON p.request_id = r.id
          WHERE r.uid = ?
          GROUP BY r.id;
          ''',
          variables: [Variable<String>(uid)],
          readsFrom: {
            _database.requests,
            _database.problems,
            _database.specializations,
          },
        )
        .get();

    final requests = result
        .map((row) => FullRepairRequestDto.fromJson(row.data).toEntity())
        .toList();

    return requests;
  }

  @override
  Future<FullRepairRequest?> getRequest({required int id}) async {
    final result = await _database
        .customSelect(
          '''SELECT 
          r.*,
          json_object(
            'id', s.id,
            'title', s.title,
            'description', s.description,
            'photo_url', s.photo_url
          ) AS specialization,
          COALESCE(
            json_group_array(
              json_object(
                'id', p.id,
                'request_id', p.request_id,
                'photo_path', p.photo_path
              )
            ) FILTER (WHERE p.id IS NOT NULL),
            '[]'
          ) AS problems
          FROM requests r
          INNER JOIN specializations s ON s.id = r.specialization_id
          LEFT JOIN problems p ON p.request_id = r.id
          WHERE r.uid = ?
          GROUP BY r.id;
          ''',
          variables: [Variable<int>(id)],
          readsFrom: {
            _database.requests,
            _database.problems,
            _database.specializations,
          },
        )
        .getSingleOrNull();

    if (result == null) return null;

    return FullRepairRequestDto.fromJson(result.data).toEntity();
  }
}
