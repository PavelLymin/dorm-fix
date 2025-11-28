import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../../authentication/data/dto/user.dart';
import '../../../authentication/model/user.dart';

abstract interface class IUserRepository {
  Future<bool> checkUserByUid({required String uid});

  Future<bool> checkUserByEmail({required String email});

  Future<void> updateUser({required AuthenticatedUser user});
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
    final response = await _client.send(
      path: '/users/check-email',
      queryParams: {'email': email},
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
  Future<void> updateUser({required AuthenticatedUser user}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final body = UserDto.fromEntity(user).toJson();
    final response = await _client.send(
      path: '/users/me',
      method: 'PUT',
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
