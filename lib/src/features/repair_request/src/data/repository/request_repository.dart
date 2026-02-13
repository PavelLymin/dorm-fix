import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../request.dart';

abstract interface class IRequestRepository {
  Future<List<FullRepairRequest>> getRequests();

  Future<FullRepairRequest> createRequest({
    required PartialRepairRequest request,
  });
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

    final data = response?['repair_requests'];
    if (data case List<Object?> list) {
      final repairRequests = list
          .whereType<Map<String, Object?>>()
          .map((json) => FullRepairRequestDto.fromJson(json).toEntity())
          .toList();

      return repairRequests;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }

  @override
  Future<FullRepairRequest> createRequest({
    required PartialRepairRequest request,
  }) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = PartialRepairRequestDto.fromEntity(request).toJson();
    final response = await _client.send(
      path: '/repairRequests',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response case Map<String, Object?> json) {
      final repairRequest = FullRepairRequestDto.fromJson(json).toEntity();
      return repairRequest;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
