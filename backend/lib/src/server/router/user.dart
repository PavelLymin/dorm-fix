import 'dart:convert';

import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/auth/src/require_user.dart';
import '../data/dto/user.dart';
import '../data/repository/user_repository.dart';
import '../model/user.dart';

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

    router.put('/users', _updateUser);

    return router.call;
  }

  Handler get publicHandler {
    final router = Router();

    router.get('/users/<email>', _getUserByEmail);
    router.get('/users/me', _getUserByUid);

    return router.call;
  }

  Future<Map<String, Object>> _readJson(Request request) async {
    final body = await request.readAsString();

    if (body.trim().isEmpty) {
      throw BadRequestException(
        message: 'Request body is empty.',
        error: {'field': 'body'},
      );
    }

    final json = jsonDecode(body);
    return json;
  }

  Response _getUser(UserEntity? user) {
    final userOrNull = user == null ? null : UserDto.fromEntity(user).toJson();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'user': userOrNull},
      },
    );
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

  Future<Response> _getUserByEmail(Request request) async {
    final email = RequireUser.getUserEmail(request);

    final user = await _userRepository.getUserByEmail(email: email);

    return _getUser(user);
  }

  Future<Response> _getUserByUid(Request request) async {
    final uid = RequireUser.getUserId(request);

    final user = await _userRepository.getUserByUid(uid: uid);

    return _getUser(user);
  }
}
