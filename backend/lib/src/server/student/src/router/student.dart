import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/src/require_user.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../student.dart';

class StudentRouter {
  StudentRouter({required this._restApi, required this._studentRepository});

  final RestApi _restApi;
  final IStudentRepository _studentRepository;

  Handler get handler {
    final router = Router();

    router.post('/students', _createStudent);

    return router.call;
  }

  Future<Map<String, Object?>> _readJson(Request request) async {
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

    final student = PartialStudentDto.fromJson(json).toEntity();
    await _studentRepository.createStudent(uid: uid, student: student);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The student was successfully created.'},
      },
    );
  }
}
