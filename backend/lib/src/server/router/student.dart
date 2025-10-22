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

    router.get('/<id>', _getStudent);
    router.post('/', _createStudent);
    router.put('/', _updateStudent);
    router.delete('/<id>', _deleteStudent);
    return router.call;
  }

  Future<Response> _createStudent(Request request) async {
    try {
      final body = await request.readAsString();

      if (body.isEmpty) {
        return Response.badRequest(body: 'Request body is empty');
      }

      final json = jsonDecode(body);
      final student = StudentDTO.fromJson(json).toEntity();
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
      final query = request.params['id'];
      if (query == null || query.isEmpty) {
        return Response.badRequest(body: 'Missing query parameter "id"');
      }

      int? id = int.tryParse(query);
      if (id == null) {
        return Response.badRequest(
          body: 'Query parameter "id" must be integer',
        );
      }

      if (id <= 0) {
        return Response.badRequest(
          body: 'Query parameter "id" must be greater than 0',
        );
      }

      await _studentRepository.deleteStudent(id: id);
      return Response.ok('The student was successfully deleted.');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }

  Future<Response> _getStudent(Request request) async {
    try {
      final query = request.params['id'];
      if (query == null || query.isEmpty) {
        return Response.badRequest(body: 'Missing query parameter "id"');
      }

      int? id = int.tryParse(query);
      if (id == null) {
        return Response.badRequest(
          body: 'Query parameter "id" must be integer',
        );
      }
      if (id <= 0) {
        return Response.badRequest(
          body: 'Query parameter "id" must be greater than 0',
        );
      }

      final student = await _studentRepository.getStudent(id: id);
      if (student == null) {
        return Response.notFound('Student not found');
      }

      final json = StudentDTO.fromEntity(student).toJson();
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
      final student = StudentDTO.fromJson(json).toEntity();
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
