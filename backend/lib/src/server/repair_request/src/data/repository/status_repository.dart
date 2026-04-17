import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';

import '../../model/status.dart';
import '../dto/status.dart';

abstract interface class IStatusRepository {
  Future<List<StatusEntity>> getStatuses({required int requestId});

  Stream<List<Statuse>> watchStatuses({required int requestId});

  Future<StatusDto> createStatus({
    required int requestId,
    required StatusEnum status,
  });
}

class StatusRepositoryImpl implements IStatusRepository {
  const StatusRepositoryImpl({required this._database});

  final Database _database;
  @override
  Future<List<StatusEntity>> getStatuses({required int requestId}) async {
    final data = await (_database.select(
      _database.statuses,
    )..where((row) => row.requestId.equals(requestId))).get();

    return data.map((e) => StatusDto.fromData(e).toEntity()).toList();
  }

  @override
  Stream<List<Statuse>> watchStatuses({required int requestId}) =>
      (_database.select(
        _database.statuses,
      )..where((row) => row.requestId.equals(requestId))).watch();

  @override
  Future<StatusDto> createStatus({
    required int requestId,
    required StatusEnum status,
  }) async {
    final data = await _database
        .into(_database.statuses)
        .insertReturning(
          StatusesCompanion(
            requestId: Value(requestId),
            title: Value(status.value),
          ),
        );

    final result = StatusDto.fromData(data);
    return result;
  }
}
