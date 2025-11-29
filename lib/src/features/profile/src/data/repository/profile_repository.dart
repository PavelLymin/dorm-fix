import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../../authentication/src/model/user.dart';
import '../../model/profile.dart';

abstract interface class IProfileRepository {
  Future<ProfileEntity> getProfile();
}

class ProfileRepositoryImpl implements IProfileRepository {
  const ProfileRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<ProfileEntity> getProfile() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/profile/me',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response case <String, Object?>{
      'profile': final Map<String, Object?> profileData,
      'role': final String roleString,
    }) {
      final role = Role.fromString(roleString);
      final profile = ProfileEntity.fromRole(role: role, json: profileData);
      return profile;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid response format.'},
    );
  }
}
