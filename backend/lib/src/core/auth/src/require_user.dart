import 'package:shelf/shelf.dart';
import '../../../server/profile/profile.dart';
import '../../rest_api/rest_api.dart';

abstract class RequireUser {
  const RequireUser();

  static String getUserId(Request request) {
    final uid = request.context['user_id'];
    if (uid is! String || uid.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid user id in request context.',
          'context': 'user_id',
        },
      );
    }

    return uid;
  }

  static Role? getUserRole(Request request) {
    final role = request.context['role'];

    if (role == null) return null;

    if (role is! String || role.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid role in request context.',
          'context': 'role',
        },
      );
    }

    return Role.fromString(role);
  }
}
