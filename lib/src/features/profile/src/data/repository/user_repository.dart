import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/rest_client/rest_client.dart';
import '../../../../authentication/authentication.dart';

abstract interface class IUserRepository {
  Future<void> update({required FirebaseUser user});

  Future<void> uploadAvatar({required File file, required String path});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
    required this._supabase,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;
  final SupabaseClient _supabase;

  @override
  Future<void> update({required FirebaseUser user}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = FirebaseUserDto.fromEntity(user).toJson();

    final response = await _client.send(
      path: '/users/me',
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

  @override
  Future<void> uploadAvatar({required File file, required String path}) async {
    await _supabase.storage
        .from('avatars')
        .upload(
          'avatar/$path',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
  }
}
