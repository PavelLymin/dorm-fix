import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../material.dart';

abstract interface class IMaterialRepository {
  Future<List<MaterialEntity>> getMaterials({int? typeId, String? query});

  Future<void> consumeMaterial({
    required int materialId,
    required int quantity,
  });
}

class MaterialRepositoryImpl implements IMaterialRepository {
  const MaterialRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<MaterialEntity>> getMaterials({
    int? typeId,
    String? query,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/materials',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
      queryParams: {
        if (typeId != null) 'type_id': typeId.toString(),
        'query': ?query,
      },
    );

    final data = response?['materials'];
    if (data case List<Object?> list) {
      final materials = list
          .whereType<Map<String, Object?>>()
          .map<MaterialEntity>((json) => MaterialDto.fromJson(json).toEntity())
          .toList();

      return materials;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }

  @override
  Future<void> consumeMaterial({
    required int materialId,
    required int quantity,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    await _client.send(
      path: '/materials/$materialId/consume',
      method: 'POST',
      body: {'quantity': quantity},
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
