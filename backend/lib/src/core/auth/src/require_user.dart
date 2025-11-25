import 'package:backend/src/app/model/application_config.dart';
import 'package:backend/src/server/model/user.dart';
import 'package:shelf/shelf.dart';
import '../../rest_api/src/rest_api.dart';

abstract class RequireUser {
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

  static String getUserRole(Request request) {
    final uid = request.context['role'];

    if (uid is! String || uid.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid user role in request context.',
          'context': 'user_id',
        },
      );
    }

    return Role.fromString(uid).name;
  }

  static String getUserEmail(Request request) {
    final email = request.url.queryParameters['email'];

    if (email is! String || email.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing path parameter "email".',
          'param': 'email',
        },
      );
    }

    if (Config().email.matchAsPrefix(email) == null) {
      throw BadRequestException(
        error: {'description': 'Invalid email format.', 'field': 'email'},
      );
    }

    return email;
  }
}
