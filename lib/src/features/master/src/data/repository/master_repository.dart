import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../../profile/profile.dart';

abstract interface class IMasterRepository {
  Future<List<MasterUser>> getMasters({int? dormId, int? specId});
}

class MasterRepositoryImpl implements IMasterRepository {
  const MasterRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<MasterUser>> getMasters({int? dormId, int? specId}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/masters',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
      queryParams: {
        if (dormId != null) 'dorm_id': dormId.toString(),
        if (specId != null) 'spec_id': specId.toString(),
      },
    );

    final data = response?['masters'];
    if (data case List<Object?> list) {
      final masters = list
          .whereType<Map<String, Object?>>()
          .map<MasterUser>((json) => MasterDto.fromJson(json).toEntity())
          .toList();

      return masters;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
