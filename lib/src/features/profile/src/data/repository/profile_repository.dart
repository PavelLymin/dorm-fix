import 'package:dorm_fix/src/features/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';

abstract interface class IProfileRepository {
  Future<ProfileUser?> getProfile();
}

class ProfileRepositoryImpl implements IProfileRepository {
  const ProfileRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<ProfileUser?> getProfile() async {
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
      final profile = ProfileUser.fromRole(role: role, json: profileData);
      return profile;
    } else if (response case <String, Object?>{'profile': null}) {
      return null;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
