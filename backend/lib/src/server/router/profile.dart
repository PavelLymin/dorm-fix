import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/auth/src/require_user.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../data/dto/master.dart';
import '../data/dto/student.dart';
import '../data/repository/master_repository.dart';
import '../data/repository/student_repository.dart';
import '../model/user.dart';

class ProfileRouter {
  ProfileRouter({
    required RestApi restApi,
    required IStudentRepository studentRepository,
    required IMasterRepository masterRepository,
  }) : _restApi = restApi,
       _studentRepository = studentRepository,
       _masterRepository = masterRepository;

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
    final response = switch (Role.fromString('student')) {
      Role.student => await _getStudent(uid),
      Role.master => await _getMaster(uid),
    };

    return response;
  }

  Future<Response> _getStudent(String uid) async {
    final student = await _studentRepository.getStudent(uid: uid);
    if (student == null) {
      throw NotFoundException(error: {'description': 'Student not found.'});
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
      throw NotFoundException(error: {'description': 'Master not found.'});
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
