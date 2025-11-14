import '../../../../../core/rest_client/rest_client.dart';
import '../../model/student.dart';
import '../dto/student.dart';

abstract interface class IStudentRepository {
  Future<void> createStudent({required StudentEntity student});

  Future<StudentEntity> getStudent({required String uid});
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
  Future<StudentEntity> getStudent({required String uid}) async {
    final response = await _client.send(path: '/students/$uid', method: 'GET');

    print(response);

    return StudentDto.fromJson(response!).toEntity();
  }
}
