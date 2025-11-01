import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../model/dormitory.dart';
import '../dto/dormitory.dart';

abstract interface class IDormitoryRepository {
  Future<List<DormitoryEntity>> search({required String query});
}

class DormitoryRepositoryImpl implements IDormitoryRepository {
  const DormitoryRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<List<DormitoryEntity>> search({required String query}) async {
    final data = await _database
        .customSelect(
          '''
          SELECT * FROM dormitories
          WHERE number LIKE ? OR name LIKE ? OR address LIKE ?
          ORDER BY number
          ''',
          variables: [
            Variable('%$query%'),
            Variable('%$query%'),
            Variable('%$query%'),
          ],
          readsFrom: {_database.dormitories},
        )
        .get();

    final result = data
        .map((row) => DormitoryDto.fromJson(row.data).toEntity())
        .toList();

    return result;
  }
}
