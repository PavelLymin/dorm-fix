import 'package:backend/src/app/model/application_config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
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

  static String getUserEmail(Request request) {
    final email = request.params['email'];

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
