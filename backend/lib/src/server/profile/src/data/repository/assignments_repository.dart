import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IAssignmentsRepository {
  Stream<MasterEntity?> watchAssignment({required int requestId});
}

class AssignmentsRepositoryImpl implements IAssignmentsRepository {
  AssignmentsRepositoryImpl({required this._database});

  final Database _database;

  @override
  Stream<MasterEntity?> watchAssignment({required int requestId}) {
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
      ).toEntity();
    });
  }
}
