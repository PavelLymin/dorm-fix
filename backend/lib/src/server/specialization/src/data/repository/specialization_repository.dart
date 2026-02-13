import '../../../../../core/database/database.dart';
import '../../../specialization.dart';

abstract interface class ISpecializationRepository {
  Future<List<SpecializationEntity>> getSpecializations();

  Future<SpecializationEntity> getSpecialization({required int id});
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

  @override
  Future<SpecializationEntity> getSpecialization({required int id}) async {
    final specializationData = await (_database.select(
      _database.specializations,
    )..where((row) => row.id.equals(id))).getSingle();

    final specialization = SpecializationDto.fromData(
      specializationData,
    ).toEntity();

    return specialization;
  }
}
