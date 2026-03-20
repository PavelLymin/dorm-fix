import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../request.dart';

abstract interface class IRequestRepository {
  Stream<List<FullRepairRequest>> getRequests({
    bool uid = false,
    int? specId,
    int? dormId,
    Status? status,
  });

  Future<void> createRequest({required PartialRepairRequest request});
}

class RequestRepositoryImpl implements IRequestRepository {
  const RequestRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<List<FullRepairRequest>> getRequests({
    bool uid = false,
    int? specId,
    int? dormId,
    Status? status,
  }) async* {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    yield* _client
        .stream(
          path: '/requests/stream',
          headers: {'Authorization': 'Bearer $token'},
          queryParams: {
            'use_uid': uid.toString(),
            if (specId != null) 'spec_id': specId.toString(),
            if (dormId != null) 'dorm_id': dormId.toString(),
            if (status != null) 'status': status.value,
          },
        )
        .map((response) {
          final data = response['data'];
          if (data case Map<String, Object?> map) {
            final requests = map['requests'];
            if (requests case List<Object?> list) {
              return list
                  .whereType<Map<String, Object?>>()
                  .map((json) => FullRepairRequestDto.fromJson(json).toEntity())
                  .toList();
            }
          }
          throw StructuredBackendException(
            error: {'description': 'Invalid data received from server.'},
            statusCode: 500,
          );
        });
  }

  @override
  Future<void> createRequest({required PartialRepairRequest request}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = PartialRepairRequestDto.fromEntity(request).toJson();
    await _client.send(
      path: '/requests',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
