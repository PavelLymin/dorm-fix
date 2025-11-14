import 'dart:convert';
import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/user.dart';
import '../data/repository/user_repository.dart';
import '../model/user.dart';

class UserRouter {
  UserRouter({required IUserRepository userRepository, required Logger logger})
    : _userRepository = userRepository,
      _logger = logger;

  final IUserRepository _userRepository;
  final Logger _logger;

  Handler get protectedHandler {
    final router = Router();

    router.put('/users', _updateUser);

    return router.call;
  }

  Handler get publicHandler {
    final router = Router();

    router.get('/users/<email>', _getUserByEmail);
    router.get('/users', _getUserByUid);

    return router.call;
  }

  Future<Map<String, dynamic>> _readJson(Request request) async {
    final body = await request.readAsString();

    if (body.trim().isEmpty) {
      throw ValidateException(
        message: 'Request body is empty.',
        details: {'field': 'body'},
      );
    }

    final json = jsonDecode(body);
    return json;
  }

  Response _getUser(UserEntity? user) {
    if (user == null) {
      return RestApi.createResponse({'user': null});
    }

    final json = UserDto.fromEntity(user).toJson();
    return RestApi.createResponse({
      'data': {'user': json},
    });
  }

  Future<Response> _updateUser(Request request) async {
    try {
      final uid = request.context['user_id'] as String;

      final json = await _readJson(request);
      final user = UserDto.fromJson(json).toEntity();
      await _userRepository.updateUser(uid: uid, user: user);

      return RestApi.createResponse({
        'data': {'message': 'The student was successfully created.'},
      }, 201);
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }

  Future<Response> _getUserByEmail(Request request) async {
    try {
      final email = request.params['email'];
      if (email == null || email.isEmpty) {
        throw ValidateException(
          message: 'Missing path parameter "email".',
          details: {'param': 'email'},
        );
      }

      final user = await _userRepository.getUserByEmail(email: email);

      return _getUser(user);
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }

  Future<Response> _getUserByUid(Request request) async {
    try {
      final uid = request.context['user_id'] as String;

      final user = await _userRepository.getUserByUid(uid: uid);

      return _getUser(user);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }
}
