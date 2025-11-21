import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/rest_client/rest_client.dart';
import '../../model/student.dart';
import '../dto/student.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required CreatedStudentEntity student});

  Future<FullStudentEntity> getStudent();
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
  Future<FullStudentEntity> getStudent() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    final response = await _client.send(
      path: '/students/me',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response is! Map<String, Object?>) {
      throw StructuredBackendException(
        error: {'description': 'The student was not found.'},
        statusCode: 404,
      );
    }

    final student = FullStudentDto.fromJson(response).toEntity();
    return student;
  }
}
