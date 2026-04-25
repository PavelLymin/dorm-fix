import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../../profile/profile.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required PartialStudent student});
}

class StudentRepositoryImpl implements IStudentRepository {
  const StudentRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> createStudent({required PartialStudent student}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = PartialStudentDto.fromEntity(student).toJson();
    await _client.send(
      path: '/students',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
