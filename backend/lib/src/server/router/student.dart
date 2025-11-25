import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/auth/src/require_user.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../data/dto/student.dart';
import '../data/repository/student_repository.dart';

class StudentRouter {
  const StudentRouter({
    required RestApi restApi,
    required IStudentRepository studentRepository,
  }) : _restApi = restApi,
       _studentRepository = studentRepository;

  final RestApi _restApi;
  final IStudentRepository _studentRepository;

  Handler get handler {
    final router = Router();

    router.get('/students/me', _getStudent);
    router.post('/students/me', _createStudent);
    router.put('/students/me', _updateStudent);
    router.delete('/students/me', _deleteStudent);

    return router.call;
  }

  Future<Map<String, Object>> _readJson(Request request) async {
    final body = await request.readAsString();

    if (body.trim().isEmpty) {
      throw BadRequestException(
        error: {'description': 'Request body is empty.', 'field': 'body'},
      );
    }

    final json = jsonDecode(body);
    return json;
  }

  Future<Response> _createStudent(Request request) async {
    final uid = RequireUser.getUserId(request);
    final json = await _readJson(request);
    final student = CreatedStudentDto.fromJson(json).toEntity();
    await _studentRepository.createStudent(student: student, uid: uid);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The student was successfully created.'},
      },
    );
  }

  Future<Response> _deleteStudent(Request request) async {
    final uid = RequireUser.getUserId(request);

    await _studentRepository.deleteStudent(uid: uid);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The student was successfully deleted.'},
      },
    );
  }

  Future<Response> _getStudent(Request request) async {
    final uid = RequireUser.getUserId(request);

    final student = await _studentRepository.getStudent(uid: uid);
    if (student == null) {
      throw NotFoundException(
        error: {'description': 'The student was not found.', 'uid': uid},
      );
    }

    final json = FullStudentDto.fromEntity(student).toJson();

    return _restApi.send(statusCode: 200, responseBody: {'data': json});
  }

  Future<Response> _updateStudent(Request request) async {
    final uid = RequireUser.getUserId(request);

    final json = await _readJson(request);
    final student = CreatedStudentDto.fromJson(json).toEntity();
    await _studentRepository.updateStudent(uid: uid, student: student);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The student was successfully updated.'},
      },
    );
  }
}
