import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../material.dart';

abstract interface class IMaterialTypeRepository {
  Future<List<MaterialTypeEntity>> getMaterialTypes();
}

class MaterialTypeRepositoryImpl implements IMaterialTypeRepository {
  const MaterialTypeRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<MaterialTypeEntity>> getMaterialTypes() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/material-types',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['material_types'];
    if (data case List<Object?> list when list.isNotEmpty) {
      final types = list
          .whereType<Map<String, Object?>>()
          .map<MaterialTypeEntity>(
            (json) => MaterialTypeDto.fromJson(json).toEntity(),
          )
          .toList();

      return types;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
