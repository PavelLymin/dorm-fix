import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/src/require_user.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../profile.dart';

class UserRouter {
  UserRouter({
    required RestApi restApi,
    required IUserRepository userRepository,
  }) : _restApi = restApi,
       _userRepository = userRepository;

  final RestApi _restApi;
  final IUserRepository _userRepository;

  Handler get protectedHandler {
    final router = Router();

    router.put('/users/me', _updateUser);

    return router.call;
  }

  Handler get publicHandler {
    final router = Router();

    router.get('/users/check_email', _checkUserByEmail);
    router.get('/users/check-uid/<uid>', _checkUserByUid);

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

  String _checkUid(Request request) {
    final uid = request.params['uid'];
    if (uid == null) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid user id in request context.',
          'query_param': 'uid',
        },
      );
    }
    return uid;
  }

  Future<Response> _updateUser(Request request) async {
    final uid = RequireUser.getUserId(request);

    final json = await _readJson(request);
    final user = UserDto.fromJson(json).toEntity();
    await _userRepository.updateUser(uid: uid, user: user);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The user was successfully updated.'},
      },
    );
  }

  Future<Response> _checkUserByEmail(Request request) async {
    final email = RequireUser.getUserEmail(request);
    final existUser = await _userRepository.checkUserByEmail(email: email);
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'exist_user': existUser},
      },
    );
  }

  Future<Response> _checkUserByUid(Request request) async {
    final uid = _checkUid(request);
    final existUser = await _userRepository.checkUserByUid(uid: uid);
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'exist_user': existUser},
      },
    );
  }
}
