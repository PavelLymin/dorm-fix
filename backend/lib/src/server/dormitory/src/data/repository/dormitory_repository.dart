import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../dormitory.dart';

abstract interface class IDormitoryRepository {
  Future<List<DormitoryEntity>> search({required String query});
  Future<List<DormitoryEntity>> getDormitories();
}

class DormitoryRepository implements IDormitoryRepository {
  const DormitoryRepository({required Database database})
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

  @override
  Future<List<DormitoryEntity>> getDormitories() async {
    final data = await _database.select(_database.dormitories).get();

    if (data.isEmpty) return [];

    final result = data
        .map((row) => DormitoryDto.fromData(row).toEntity())
        .toList();

    return result;
  }
}
