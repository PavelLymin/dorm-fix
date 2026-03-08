import 'package:drift/drift.dart';

import '../../../../../core/database/database.dart';
import '../../../specialization.dart';

abstract interface class ISpecializationRepository {
  Future<List<SpecializationEntity>> getSpecializations();

  Stream<SpecializationEntity> watchSpecialization({required int requestId});
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
  Stream<SpecializationEntity> watchSpecialization({required int requestId}) =>
      (_database.select(_database.specializations).join([
        innerJoin(
          _database.requests,
          _database.specializations.id.equalsExp(
            _database.requests.specializationId,
          ),
        ),
      ])..where(_database.requests.id.equals(requestId))).watchSingle().map(
        (row) => SpecializationDto.fromData(
          row.readTable(_database.specializations),
        ).toEntity(),
      );
}
