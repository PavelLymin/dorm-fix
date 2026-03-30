import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../../authentication/authentication.dart';

abstract interface class IProfileRepository {
  Future<ProfileUser?> getProfile();

  Stream<UserEntity> userChanges();
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

  @override
  Stream<UserEntity> userChanges() {
    StreamSubscription? streamSubscription;
    final controller = StreamController<UserEntity>(
      onCancel: () => streamSubscription?.cancel(),
    );
    streamSubscription = _firebaseAuth.userChanges().listen((data) async {
      if (data != null) {
        try {
          final profile = await getProfile();
          if (profile == null) {
            final user = FirebaseUserDto.fromFirebase(data).toEntity();
            controller.add(user);
          } else {
            final role = profile.mapRoleUser(
              student: (student) => student,
              master: (master) => master,
            );
            controller.add(role);
          }
        } catch (e) {
          controller.addError(e);
        }
      } else {
        controller.add(const NotAuthenticatedUser());
      }
    }, onDone: () => streamSubscription?.cancel());

    return controller.stream;
  }
}
