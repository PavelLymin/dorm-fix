import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../model/building.dart';
import '../dto/building.dart';

abstract interface class IBuildingRepository {
  Future<List<BuildingEntity>> search({required String query});
}

class BuildingRepositoryImpl implements IBuildingRepository {
  const BuildingRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<List<BuildingEntity>> search({required String query}) async {
    final data = await _database
        .customSelect(
          '''
          SELECT * FROM buildings
          WHERE number LIKE ? OR name LIKE ? OR address LIKE ?
          ORDER BY number
          ''',
          variables: [
            Variable('%$query%'),
            Variable('%$query%'),
            Variable('%$query%'),
          ],
          readsFrom: {_database.buildings},
        )
        .get();

    final result = data
        .map((row) => BuildingDto.fromJson(row.data).toEntity())
        .toList();

    return result;
  }
}
