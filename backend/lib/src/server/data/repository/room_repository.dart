import 'package:backend/src/core/database/database.dart';
import 'package:drift/drift.dart';

import '../../model/room.dart';
import '../dto/room.dart';

abstract interface class IRoomRepository {
  Future<List<RoomEntity>> searchRooms({
    required int dormitoryId,
    required String query,
  });
}

class RoomRepository implements IRoomRepository {
  RoomRepository({required Database database}) : _database = database;
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

  // final data = await (_database.select(
  //   _database.rooms,
  // )..where((row) => row.dormitoryId.equals(dormitoryId))).get();

  // if (data.isEmpty) return [];

  // final result = data.map((row) => RoomDto.fromData(row).toEntity()).toList();

  // return result;
  // }
}
