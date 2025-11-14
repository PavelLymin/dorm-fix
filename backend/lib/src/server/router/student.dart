import 'dart:convert';

import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../data/dto/student.dart';
import '../data/repository/student_repository.dart';

class StudentRouter {
  const StudentRouter({
    required IStudentRepository studentRepository,
    required Logger logger,
  }) : _studentRepository = studentRepository,
       _logger = logger;

  final IStudentRepository _studentRepository;
  final Logger _logger;

  Handler get handler {
    final router = Router();

    router.get('/students/me', _getStudent);
    router.post('/students/me', _createStudent);
    router.put('/students/me', _updateStudent);
    router.delete('/students/me', _deleteStudent);
    return router.call;
  }

  Future<Map<String, dynamic>> _readJson(Request request) async {
    final body = await request.readAsString();

    if (body.trim().isEmpty) {
      throw ValidateException(
        message: 'Request body is empty.',
        details: {'field': 'body'},
      );
    }

    final json = jsonDecode(body);
    return json;
  }

  Future<Response> _createStudent(Request request) async {
    try {
      final json = await _readJson(request);
      final student = StudentDto.fromJson(json).toEntity();
      await _studentRepository.createStudent(student: student);

      return RestApi.createResponse({
        'data': {'message': 'The student was successfully created.'},
      }, 201);
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }

  Future<Response> _deleteStudent(Request request) async {
    try {
      final uid = request.context['user_id'] as String;

      await _studentRepository.deleteStudent(uid: uid);

      return RestApi.createResponse({
        'data': {'message': 'The student was successfully deleted.'},
      });
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }

  Future<Response> _getStudent(Request request) async {
    try {
      final uid = request.context['user_id'] as String;

      final student = await _studentRepository.getStudent(uid: uid);
      if (student == null) {
        throw NotFoundException(
          message: 'Student not found.',
          details: {'uid': uid},
        );
      }

      final json = StudentDto.fromEntity(student).toJson();

      return RestApi.createResponse({
        'data': {'student': json},
      });
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }

  Future<Response> _updateStudent(Request request) async {
    try {
      final uid = request.context['user_id'] as String;

      final json = await _readJson(request);
      final student = StudentDto.fromJson(json).toEntity();
      await _studentRepository.updateStudent(uid: uid, student: student);

      return RestApi.createResponse({
        'data': {'message': 'The student was successfully updated.'},
      }, 201);
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }
}
