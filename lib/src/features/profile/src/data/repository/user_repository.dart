import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';

abstract interface class IUserRepository {
  Future<bool> checkUserByUid({required String uid});

  Future<bool> checkUserByEmail({required String email});

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
  Future<bool> checkUserByEmail({required String email}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/users/check_email',
      queryParams: {'email': email},
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response?['exist_user'] case final bool existUser) {
      return existUser;
    }

    throw StructuredBackendException(
      error: {'message': 'Invalid response format'},
    );
  }

  @override
  Future<bool> checkUserByUid({required String uid}) async {
    final response = await _client.send(
      path: '/users/check-uid/$uid',
      method: 'GET',
    );
    if (response?['exist_user'] case final bool existUser) {
      return existUser;
    }

    throw StructuredBackendException(
      error: {'message': 'Invalid response format'},
    );
  }

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
      );
    }
  }
}
