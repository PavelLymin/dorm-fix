import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../model/profile.dart';
import '../dto/student.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required CreatedStudentEntity student});

  Future<void> updateUserProfile({required FullStudentEntity student});
}

class StudentRepositoryImpl implements IStudentRepository {
  const StudentRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> createStudent({required CreatedStudentEntity student}) async {
    final body = CreatedStudentDto.fromEntity(student).toJson();

    await _client.send(path: '/students', method: 'POST', body: body);
  }

  @override
  Future<void> updateUserProfile({required FullStudentEntity student}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final body = FullStudentDto.fromEntity(student).toJson();
    final response = await _client.send(
      path: '/students/me',
      method: 'PUT',
      headers: {'Authorization': 'Bearer $token'},
      body: body,
    );

    if (response?['status_code'] != 201) {
      throw StructuredBackendException(
        error: {'description': 'Failed to update student profile.'},
      );
    }
  }
}
