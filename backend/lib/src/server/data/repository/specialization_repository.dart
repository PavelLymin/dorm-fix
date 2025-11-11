import '../../../core/database/database.dart';
import '../../model/specialization.dart';
import '../dto/specialization.dart';

abstract interface class ISpecializationRepository {
  Future<List<SpecializationEntity>> getSpecializations();
}

class SpecializationRepositoryImpl implements ISpecializationRepository {
  const SpecializationRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<List<SpecializationEntity>> getSpecializations() async {
    final data = await _database.select(_database.specializations).get();

    if (data.isEmpty) return [];

    final specializations = data
        .map((row) => SpecializationDto.fromData(row).toEntity())
        .toList();

    return specializations;
  }
}
