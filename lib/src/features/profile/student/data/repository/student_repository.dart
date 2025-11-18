import '../../../../../core/rest_client/rest_client.dart';
import '../../model/student.dart';
import '../dto/student.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required StudentEntity student});

  Future<StudentEntity> getStudent();
}

class StudentRepositoryImpl implements IStudentRepository {
  const StudentRepositoryImpl({required RestClientHttp client})
    : _client = client;

  final RestClientHttp _client;

  @override
  Future<void> createStudent({required StudentEntity student}) async {
    final body = StudentDto.fromEntity(student).toJson();

    await _client.send(path: '/students', method: 'POST', body: body);
  }

  @override
  Future<StudentEntity> getStudent() async {
    final response = await _client.send(path: '/students/me', method: 'GET');

    if (response == null) {
      throw StructuredBackendException(
        error: {'description': 'The student was not found.'},
        statusCode: 404,
      );
    }

    final student = StudentDto.fromJson(response).toEntity();
    return student;
  }
}
