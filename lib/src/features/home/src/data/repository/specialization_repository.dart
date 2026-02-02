import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../home.dart';

abstract interface class ISpecializationRepository {
  Future<List<SpecializationEntity>> getSpecializations();
}

class SpecializationRepositoryImpl implements ISpecializationRepository {
  SpecializationRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<SpecializationEntity>> getSpecializations() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/specializations',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['specializations'];
    if (data case List<Object?> list when list.isNotEmpty) {
      final specializations = list
          .whereType<Map<String, Object?>>()
          .map<SpecializationEntity>(
            (json) => SpecializationDto.fromJson(json).toEntity(),
          )
          .toList();

      return specializations;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
