import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/src/require_user.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../profile.dart';

class ProfileRouter {
  ProfileRouter({
    required this._restApi,
    required this._studentRepository,
    required this._masterRepository,
  });

  final RestApi _restApi;
  final IStudentRepository _studentRepository;
  final IMasterRepository _masterRepository;

  Handler get handler {
    final router = Router();

    router.get('/profile/me', _getProfile);

    return router.call;
  }

  Future<Response> _getProfile(Request request) async {
    final uid = RequireUser.getUserId(request);
    // final role = RequireUser.getUserRole(request);
    final response = switch (Role.fromString('master')) {
      .student => await _getStudent(uid),
      .master => await _getMaster(uid),
    };

    return response;
  }

  Future<Response> _getStudent(String uid) async {
    final student = await _studentRepository.getStudent(uid: uid);

    if (student == null) {
      return _restApi.send(
        statusCode: 200,
        responseBody: {
          'data': {'profile': null},
        },
      );
    }

    final json = FullStudentDto.fromEntity(student).toJson();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'profile': json, 'role': Role.student.name},
      },
    );
  }

  Future<Response> _getMaster(String uid) async {
    final master = await _masterRepository.getMaster(uid: uid);
    if (master == null) {
      return _restApi.send(
        statusCode: 200,
        responseBody: {
          'data': {'profile': null},
        },
      );
    }
    final json = MasterDto.fromEntity(master).toJson();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'profile': json, 'role': Role.master.name},
      },
    );
  }
}
