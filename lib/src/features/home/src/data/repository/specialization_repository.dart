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

    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The specializations was not found.'},
        statusCode: 404,
      );
    }

    final specializations = data
        .map((json) => SpecializationDto.fromJson(json).toEntity())
        .toList();

    return specializations;
  }
}
