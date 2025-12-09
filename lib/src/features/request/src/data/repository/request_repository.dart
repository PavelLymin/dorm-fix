import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../request.dart';

abstract interface class IRequestRepository {
  Future<void> createRequest({required CreatedRequestEntity request});
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
  Future<void> createRequest({required CreatedRequestEntity request}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final body = CreatedRequestDto.fromEntity(request).toJson();

    await _client.send(
      path: '/requests',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
