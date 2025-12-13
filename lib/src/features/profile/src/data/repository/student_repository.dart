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
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = CreatedStudentDto.fromEntity(student).toJson();
    final response = await _client.send(
      path: '/students/me',
      method: 'POST',
      headers: {'Authorization': 'Bearer $token'},
      body: body,
    );
    print('Full response: $response');
    print('Response type: ${response.runtimeType}');

    if (response is Map) {
      print('Response keys: ${response?.keys}');
      print('Response values: ${response?.values}');
    }

    // if (response?['status_code'] != 201) {
    //   throw StructuredBackendException(
    //     error: {'description': 'Failed to create student.'},
    //   );
    // }
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
