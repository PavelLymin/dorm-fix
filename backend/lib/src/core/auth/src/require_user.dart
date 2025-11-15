import 'package:backend/src/app/model/application_config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../rest_api/src/rest_api.dart';

abstract class RequireUser {
  static String getUserId(Request request) {
    final uid = request.context['user_id'];

    if (uid is! String || uid.isEmpty) {
      throw BadRequestException(
        message: 'Missing or invalid user id in request context.',
        error: {'context': 'user_id'},
      );
    }

    return uid;
  }

  static String getUserEmail(Request request) {
    final email = request.params['email'];

    if (email is! String || email.isEmpty) {
      throw BadRequestException(
        message: 'Missing path parameter "email".',
        error: {'param': 'email'},
      );
    }

    if (Config().email.matchAsPrefix(email) == null) {
      throw BadRequestException(
        message: 'Invalid email format.',
        error: {'field': 'email'},
      );
    }

    return email;
  }
}
