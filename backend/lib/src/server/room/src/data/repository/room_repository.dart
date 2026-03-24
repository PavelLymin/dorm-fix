import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
import '../../model/room.dart';
import '../dto/room.dart';

abstract interface class IRoomRepository {
  Future<List<RoomEntity>> searchRooms({
    required int dormitoryId,
    required String query,
  });

  Future<List<RoomEntity>> getRooms({required int dormitoryId});
}

class RoomRepository implements IRoomRepository {
  RoomRepository({required this._database});
  final Database _database;

  @override
  Future<List<RoomEntity>> searchRooms({
    required int dormitoryId,
    required String query,
  }) async {
    final pattern = '%$query%';
    final data =
        await (_database.select(_database.rooms)..where((row) {
              return row.dormitoryId.equals(dormitoryId) &
                  row.number.like(pattern);
            }))
            .get();

    final result = data.map((row) => RoomDto.fromData(row).toEntity()).toList();

    return result;
  }

  @override
  Future<List<RoomEntity>> getRooms({required int dormitoryId}) async {
    final data = await (_database.select(
      _database.rooms,
    )..where((row) => row.dormitoryId.equals(dormitoryId))).get();

    final result = data.map((row) => RoomDto.fromData(row).toEntity()).toList();

    return result;
  }
}
