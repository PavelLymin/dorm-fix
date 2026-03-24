import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../room.dart';

abstract interface class IRoomRepository {
  Future<List<RoomEntity>> getRooms({String? query, required int dormitoryId});
}

class RoomRepository implements IRoomRepository {
  RoomRepository({required this._client, required this._firebaseAuth});

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<RoomEntity>> getRooms({
    String? query,
    required int dormitoryId,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/rooms/$dormitoryId',
      method: 'GET',
      queryParams: {
        if (query != null && query.trim().isNotEmpty) 'query': query,
      },
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['rooms'];
    if (data case List<Object?> rooms) {
      return rooms
          .whereType<Map<String, Object?>>()
          .map((json) => RoomDto.fromJson(json).toEntity())
          .toList();
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
