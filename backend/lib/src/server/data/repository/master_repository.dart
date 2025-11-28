import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/master.dart';
import '../dto/master.dart';

abstract interface class IMasterRepository {
  Future<MasterEntity?> getMaster({required String uid});
}

class MasterRepository implements IMasterRepository {
  MasterRepository({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<MasterEntity?> getMaster({required String uid}) async {
    final data = await (_database.select(_database.masters).join([
      innerJoin(
        _database.users,
        _database.users.uid.equalsExp(_database.masters.uid),
      ),
      innerJoin(
        _database.dormitories,
        _database.dormitories.id.equalsExp(_database.masters.dormitoryId),
      ),
    ])..where(_database.users.uid.equals(uid))).getSingleOrNull();

    if (data == null) return null;

    final master = MasterDto.fromData(
      data.readTable(_database.masters),
      data.readTable(_database.users),
      data.readTable(_database.dormitories),
    ).toEntity();

    return master;
  }
}
