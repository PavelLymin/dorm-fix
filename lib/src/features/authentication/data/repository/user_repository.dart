import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../../profile/data/dto/student.dart';
import '../../model/user.dart';

abstract interface class IUserRepository {
  Future<bool> checkUserByUid({required String uid});

  Future<bool> checkUserByEmail({required String email});

  Future<UserEntity> getUser();
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
  Future<UserEntity> getUser() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/users',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response case <String, Object?>{
      'user': final Map<String, Object?> user,
      'role': final String roleString,
    }) {
      final role = Role.fromString(roleString);
      return _getUserByRole(role, user);
    }

    throw StructuredBackendException(
      error: {'message': 'Invalid response format'},
    );
  }

  UserEntity _getUserByRole(Role role, Map<String, Object?> data) {
    final user = switch (role) {
      Role.student => FullStudentDto.fromJson(data).toEntity(),
      //TODO: add master dto
      Role.master => FullStudentDto.fromJson(data).toEntity(),
    };

    return user;
  }
}
