import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../profile.dart';

abstract interface class IAssignmentsRepository {
  Future<MasterEntity?> getAssignment({required int requestId});
}

class AssignmentsRepositoryImpl implements IAssignmentsRepository {
  AssignmentsRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<MasterEntity?> getAssignment({required int requestId}) async {
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
        _database.specializations.id.equalsExp(
          _database.masters.specializationId,
        ),
      ),
    ]);
    query.where(_database.assignments.requestId.equals(requestId));
    query.orderBy([
      OrderingTerm(expression: _database.assignments.createdAt, mode: .desc),
    ]);
    query.limit(1);

    final data = await query.getSingleOrNull();
    if (data == null) return null;
    final master = MasterDto.fromData(
      data.readTable(_database.masters),
      data.readTable(_database.users),
      data.readTable(_database.dormitories),
      data.readTable(_database.specializations),
    ).toEntity();

    return master;
  }
}
