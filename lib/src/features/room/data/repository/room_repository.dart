import 'package:dorm_fix/src/features/room/data/dto/room.dart';
import 'package:dorm_fix/src/features/room/model/room.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/rest_client/rest_client.dart';

abstract interface class IRoomRepository {
  Future<List<RoomEntity>> searchRoomsByDormitoryId({
    required int dormitoryId,
    required String query,
  });
}

class RoomRepository implements IRoomRepository {
  RoomRepository({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;
  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<RoomEntity>> searchRoomsByDormitoryId({
    required int dormitoryId,
    required String query,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/rooms/$dormitoryId',
      method: 'GET',
      queryParams: {'query': query},
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['rooms'];

    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The rooms was not found.'},
        statusCode: 404,
      );
    }

    final rooms = data
        .map((json) => RoomDto.fromJson(json).toEntity())
        .toList();

    return rooms;
  }
}
