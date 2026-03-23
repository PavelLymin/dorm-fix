import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../dormitory.dart';

abstract class IDormitoryRepository {
  Future<List<DormitoryEntity>> searchDormitories({required String query});

  Future<List<DormitoryEntity>> getDormitories();
}

class DormitoryRepository implements IDormitoryRepository {
  const DormitoryRepository({
    required this._client,
    required this._firebaseAuth,
  });
  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<DormitoryEntity>> searchDormitories({
    required String query,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/dormitories/search',
      method: 'GET',
      queryParams: {'query': query},
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['dormitories'];

    if (data case List<Object?> dormitories) {
      return dormitories
          .whereType<Map<String, Object?>>()
          .map((json) => DormitoryDto.fromJson(json).toEntity())
          .toList();
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }

  @override
  Future<List<DormitoryEntity>> getDormitories() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/dormitories',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    log(response.toString());

    final data = response?['dormitories'];

    if (data case List<Object?> dormitories) {
      return dormitories
          .whereType<Map<String, Object?>>()
          .map((json) => DormitoryDto.fromJson(json).toEntity())
          .toList();
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
