import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../yandex_mapkit.dart';

abstract class IDormitoryRepository {
  Future<List<DormitoryEntity>> searchDormitories({required String query});
  Future<List<DormitoryEntity>> getDormitories();
}

class DormitoryRepository implements IDormitoryRepository {
  const DormitoryRepository({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;
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

    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The dormitories was not found.'},
        statusCode: 404,
      );
    }

    final dormitories = data
        .map((json) => DormitoryDto.fromJson(json).toEntity())
        .toList();

    return dormitories;
  }

  @override
  Future<List<DormitoryEntity>> getDormitories() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/dormitories',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['dormitories'];

    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The dormitories was not found.'},
        statusCode: 404,
      );
    }

    final dormitories = data
        .map((json) => DormitoryDto.fromJson(json).toEntity())
        .toList();

    return dormitories;
  }
}
