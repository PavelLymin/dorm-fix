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
}
