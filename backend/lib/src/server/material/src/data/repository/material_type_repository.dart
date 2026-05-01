import '../../../../../core/database/database.dart';
import '../../../material.dart';

abstract interface class IMaterialTypeRepository {
  Future<List<MaterialTypeEntity>> getMaterialTypes();
}

class MaterialTypeRepositoryImpl implements IMaterialTypeRepository {
  const MaterialTypeRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<List<MaterialTypeEntity>> getMaterialTypes() async {
    final data = await _database.select(_database.materialTypes).get();

    return data.map((row) => MaterialTypeDto.fromData(row).toEntity()).toList();
  }
}
