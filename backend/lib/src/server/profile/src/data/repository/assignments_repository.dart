import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../../master/master.dart';

abstract interface class IAssignmentsRepository {
  Stream<MasterDto?> watchAssignment({required int requestId});

  Future<void> createAssignment({
    required int requestId,
    required String masterUid,
  });
}

class AssignmentsRepositoryImpl implements IAssignmentsRepository {
  AssignmentsRepositoryImpl({required this._database});

  final Database _database;

  @override
  Stream<MasterDto?> watchAssignment({required int requestId}) {
    final query = _database.select(_database.assignments).join([
      innerJoin(
        _database.masters,
        _database.masters.uid.equalsExp(_database.assignments.uid),
      ),
      innerJoin(
        _database.users,
        _database.users.uid.equalsExp(_database.masters.uid),
      ),
      innerJoin(
        _database.dormitories,
        _database.dormitories.id.equalsExp(_database.masters.dormitoryId),
      ),
      innerJoin(
        _database.specializations,
        _database.specializations.id.equalsExp(_database.masters.specId),
      ),
    ]);
    query.where(_database.assignments.requestId.equals(requestId));

    return query.watchSingleOrNull().map((row) {
      if (row == null) return null;
      return MasterDto.fromData(
        row.readTable(_database.masters),
        row.readTable(_database.users),
        row.readTable(_database.dormitories),
        row.readTable(_database.specializations),
      );
    });
  }

  @override
  Future<void> createAssignment({
    required int requestId,
    required String masterUid,
  }) async => await _database
      .into(_database.assignments)
      .insert(
        AssignmentsCompanion.insert(requestId: requestId, uid: masterUid),
      );
}
