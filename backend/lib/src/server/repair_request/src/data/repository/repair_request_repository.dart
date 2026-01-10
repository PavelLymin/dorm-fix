import 'dart:convert';

import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../repair_request.dart';

abstract interface class IRequestRepository {
  Future<FullRepairRequestEntity> createRequest({
    required String uid,
    required CreatedRepairRequestEntity request,
  });

  Future<List<FullRepairRequestEntity>> getRequests({required String uid});

  Future<FullRepairRequestEntity?> getRequest({required int id});
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<FullRepairRequestEntity> createRequest({
    required String uid,
    required CreatedRepairRequestEntity request,
  }) async {
    final dto = CreatedRepairRequestDto.fromEntity(request);
    final data = await _addRequestToDb(uid, dto);
    final fullRequest = FullRepairRequestDto.fromData(
      data.request,
      data.problems,
    ).toEntity();

    return fullRequest;
  }

  Future<({Request request, List<Problem> problems})> _addRequestToDb(
    String uid,
    CreatedRepairRequestDto dto,
  ) async {
    late final Request request;
    final problems = <Problem>[];
    await _database.transaction(() async {
      request = await _database
          .into(_database.requests)
          .insertReturning(dto.toCompanion(uid: uid));

      for (final problem in dto.imagePaths) {
        final problemCompanion = ProblemsCompanion(
          requestId: Value(request.id),
          photoPath: Value(problem),
        );
        final data = await _database
            .into(_database.problems)
            .insertReturning(problemCompanion);
        problems.add(data);
      }
    });

    return (request: request, problems: problems);
  }

  @override
  Future<List<FullRepairRequestEntity>> getRequests({
    required String uid,
  }) async {
    final result = await _database
        .customSelect(
          '''SELECT 
          r.*,
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
          LEFT JOIN problems p ON p.request_id = r.id
          WHERE r.uid = ?
          GROUP BY r.id;
          ''',
          variables: [Variable<String>(uid)],
          readsFrom: {_database.requests, _database.problems},
        )
        .get();

    final requests = result.map((row) {
      final problemsJson = row.data['problems'] as String? ?? '[]';
      final List<dynamic> parsed = jsonDecode(problemsJson);
      final problemsList = parsed
          .map((e) => Map<String, Object?>.from(e))
          .toList();
      return FullRepairRequestDto.fromJson(row.data, problemsList).toEntity();
    }).toList();

    return requests;
  }

  @override
  Future<FullRepairRequestEntity?> getRequest({required int id}) async {
    final result = await _database
        .customSelect(
          '''SELECT 
            r.*,
            json_group_array(
              json_object(
                'id', p.id,
                'request_id', p.request_id,
                'photo_path', p.photo_path
              )
            ) AS problems
          FROM requests r
          LEFT JOIN problems p ON p.request_id = r.id
          WHERE r.id = ?
          GROUP BY r.id''',
          variables: [Variable<int>(id)],
          readsFrom: {_database.requests, _database.problems},
        )
        .getSingleOrNull();

    if (result == null) return null;

    final problemsJson = result.data['problems'] as String? ?? '[]';
    final List<dynamic> parsed = jsonDecode(problemsJson);
    final problemsList = parsed
        .map((e) => Map<String, Object?>.from(e as Map))
        .toList();

    final request = FullRepairRequestDto.fromJson(
      result.data,
      problemsList,
    ).toEntity();

    return request;
  }
}
