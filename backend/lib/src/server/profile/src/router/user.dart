import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../profile.dart';

class UserRouter {
  UserRouter({required this._restApi, required this._userRepository});

  final RestApi _restApi;
  final IUserRepository _userRepository;

  Handler get handler {
    final router = Router();

    router.patch('/users/me', _updateUser);

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

  Future<Response> _updateUser(Request request) async {
    final json = await _readJson(request);
    await _userRepository.update(user: UserDto.fromJson(json).toEntity());

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The user was successfully updated.'},
      },
    );
  }
}
