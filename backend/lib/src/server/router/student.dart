import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/student.dart';
import '../data/repository/student_repository.dart';

class StudentRouter {
  const StudentRouter({required IStudentRepository studentRepository})
    : _studentRepository = studentRepository;

  final IStudentRepository _studentRepository;

  Handler get handler {
    final router = Router();

    router.get('/student/<id>', _getStudent);
    router.post('/student', _createStudent);
    router.put('/student', _updateStudent);
    router.delete('/student/<id>', _deleteStudent);
    return router.call;
  }

  Future<Response> _createStudent(Request request) async {
    try {
      final body = await request.readAsString();

      if (body.isEmpty) {
        return Response.badRequest(body: 'Request body is empty');
      }

      final json = jsonDecode(body);
      final student = StudentDto.fromJson(json).toEntity();
      await _studentRepository.createStudent(student: student);
      return Response(201, body: 'The student was successfully created.');
    } on FormatException catch (e) {
      return Response.badRequest(body: 'Invalid JSON format: ${e.toString()}');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }

  Future<Response> _deleteStudent(Request request) async {
    try {
      final uid = request.params['uid'];
      if (uid == null || uid.isEmpty) {
        return Response.badRequest(body: 'Missing path parameter "id"');
      }

      if (uid != request.context['user_id']) {
        return Response.forbidden(
          'You are not allowed to delete this student.',
        );
      }

      await _studentRepository.deleteStudent(uid: uid);
      return Response.ok('The student was successfully deleted.');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }

  Future<Response> _getStudent(Request request) async {
    try {
      final uid = request.params['uid'];
      if (uid == null || uid.isEmpty) {
        return Response.badRequest(body: 'Missing path parameter "id"');
      }

      if (uid != request.context['user_id']) {
        return Response.forbidden(
          'You are not allowed to delete this student.',
        );
      }

      final student = await _studentRepository.getStudent(uid: uid);
      if (student == null) {
        return Response.notFound('Student not found');
      }

      final json = StudentDto.fromEntity(student).toJson();
      return Response.ok(jsonEncode(json));
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }

  Future<Response> _updateStudent(Request request) async {
    try {
      final body = await request.readAsString();

      if (body.isEmpty) {
        return Response.badRequest(body: 'Request body is empty');
      }

      final json = jsonDecode(body);
      final student = StudentDto.fromJson(json).toEntity();
      await _studentRepository.updateStudent(student: student);

      return Response.ok('The student was successfully updated');
    } on FormatException catch (e) {
      return Response.badRequest(body: 'Invalid JSON format: ${e.toString()}');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }
}
