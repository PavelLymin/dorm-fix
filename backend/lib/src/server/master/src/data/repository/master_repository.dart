import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../master.dart';

abstract interface class IMasterRepository {
  Future<MasterEntity?> getMaster({required String uid});

  Future<List<MasterEntity>> getMasters({int? dormId, int? specId});
}

class MasterRepository implements IMasterRepository {
  MasterRepository({required this._database});

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
      innerJoin(
        _database.specializations,
        _database.specializations.id.equalsExp(_database.masters.specId),
      ),
    ])..where(_database.users.uid.equals(uid))).getSingleOrNull();

    if (data == null) return null;

    final master = MasterDto.fromData(
      data.readTable(_database.masters),
      data.readTable(_database.users),
      data.readTable(_database.dormitories),
      data.readTable(_database.specializations),
    ).toEntity();

    return master;
  }

  @override
  Future<List<MasterEntity>> getMasters({int? dormId, int? specId}) async {
    final query = (_database.select(_database.masters).join([
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
    ]));

    if (dormId != null) {
      query.where(_database.masters.dormitoryId.equals(dormId));
    }

    if (specId != null) query.where(_database.masters.specId.equals(specId));

    final data = await query.get();

    final masters = data
        .map(
          (e) => MasterDto.fromData(
            e.readTable(_database.masters),
            e.readTable(_database.users),
            e.readTable(_database.dormitories),
            e.readTable(_database.specializations),
          ).toEntity(),
        )
        .toList();

    return masters;
  }
}
