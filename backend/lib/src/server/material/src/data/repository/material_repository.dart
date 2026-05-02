import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../../material.dart';

abstract interface class IMaterialRepository {
  Future<List<MaterialEntity>> getMaterials({int? typeId});

  Future<void> consumeMaterial(int materialId, int usedQuantity);
}

class MaterialRepositoryImpl implements IMaterialRepository {
  const MaterialRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<List<MaterialEntity>> getMaterials({int? typeId}) async {
    final query = _database.select(_database.materials).join([
      innerJoin(
        _database.materialTypes,
        _database.materialTypes.id.equalsExp(_database.materials.typeId),
      ),
    ]);
    if (typeId != null) query.where(_database.materials.typeId.equals(typeId));

    final data = await query.get();

    return data
        .map(
          (row) => MaterialDto.fromData(
            row.readTable(_database.materials),
            row.readTable(_database.materialTypes),
          ).toEntity(),
        )
        .toList();
  }

  @override
  Future<void> consumeMaterial(int materialId, int usedQuantity) async {
    await (_database.update(
      _database.materials,
    )..where((t) => t.id.equals(materialId))).write(
      MaterialsCompanion.custom(
        quantity: _database.materials.quantity - Constant(usedQuantity),
      ),
    );
  }
}
