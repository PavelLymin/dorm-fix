import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';

abstract interface class IUserRepository {
  Future<void> updatePhoneNumber({required String phoneNumber});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> updatePhoneNumber({required String phoneNumber}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = <String, Object?>{'phone_number': phoneNumber};
    final response = await _client.send(
      path: '/users/me/phone',
      method: 'PATCH',
      headers: {'Authorization': 'Bearer $token'},
      body: body,
    );

    if (response?['status_code'] != 201) {
      throw StructuredBackendException(
        error: {'description': 'Failed to update user profile.'},
        statusCode: 500,
      );
    }
  }
}
