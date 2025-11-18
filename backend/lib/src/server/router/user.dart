import 'dart:convert';

import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/auth/src/require_user.dart';
import '../data/dto/user.dart';
import '../data/repository/user_repository.dart';

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

  Future<Response> _getUserByEmail(Request request) async {
    final email = RequireUser.getUserEmail(request);

    final user = await _userRepository.getUserByEmail(email: email);

    if (user == null) {
      throw ConflictException(
        error: {'description': 'Email already exists.', 'param': 'email'},
      );
    }

    final json = UserDto.fromEntity(user).toJson();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'user': json},
      },
    );
  }

  Future<Response> _getUserByUid(Request request) async {
    final uid = RequireUser.getUserId(request);

    final user = await _userRepository.getUserByUid(uid: uid);

    if (user == null) {
      throw NotFoundException(
        error: {'description': 'User not found.', 'context': 'user_id'},
      );
    }

    final json = UserDto.fromEntity(user).toJson();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'user': json},
      },
    );
  }
}
