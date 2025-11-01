import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/user.dart';
import '../data/repository/user_repository.dart';

class UserRouter {
  UserRouter({required IUserRepository userRepository})
    : _userRepository = userRepository;

  final IUserRepository _userRepository;

  Handler get handler {
    final router = Router();

    router.put('/users', _updateUser);
    return router.call;
  }

  Future<Response> _updateUser(Request request) async {
    try {
      final body = await request.readAsString();

      if (body.isEmpty) {
        return Response.badRequest(body: 'Request body is empty');
      }

      final json = jsonDecode(body);
      final user = UserDto.fromJson(json).toEntity();
      await _userRepository.updateUser(user: user);

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
