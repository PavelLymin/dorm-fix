import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../request.dart';

abstract interface class IRequestRepository {
  Future<List<FullRepairRequest>> getRequests();

  Future<void> createRequest({required CreatedRepairRequest request});
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<FullRepairRequest>> getRequests() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/repairRequests',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['requests'];
    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The specializations was not found.'},
        statusCode: 404,
      );
    }

    final specializations = data
        .map((json) => FullRepairRequestDto.fromJson(json).toEntity())
        .toList();

    return specializations;
  }

  @override
  Future<void> createRequest({required CreatedRepairRequest request}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = CreatedRepairRequestDto.fromEntity(request).toJson();
    await _client.send(
      path: '/repairRequests',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
