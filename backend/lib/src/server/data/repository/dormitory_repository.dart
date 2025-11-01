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
    final pattern = '%$query%';
    final data =
        await (_database.select(_database.dormitories)..where((row) {
              final numberString = row.number.cast<String>();
              return numberString.like(pattern) |
                  row.name.like(pattern) |
                  row.address.like(pattern);
            }))
            .get();

    final result = data
        .map((row) => DormitoryDto.fromData(row).toEntity())
        .toList();

    return result;
  }
}
