import '../../../../../core/rest_client/rest_client.dart';
import '../../model/student.dart';
import '../dto/student.dart';

abstract interface class IStudentRepository {
  Future<StudentEntity> getStudent({required String uid});
}

class StudentRepositoryImpl implements IStudentRepository {
  const StudentRepositoryImpl({required RestClientHttp client})
    : _client = client;

  final RestClientHttp _client;

  @override
  Future<StudentEntity> getStudent({required String uid}) async {
    final response = await _client.send(path: '/students/$uid', method: 'GET');

    return StudentDto.fromJson(
      response!['data'] as Map<String, dynamic>,
    ).toEntity();
  }
}
