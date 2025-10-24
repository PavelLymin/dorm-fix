import 'package:firebase_admin/firebase_admin.dart';
import 'package:shelf/shelf.dart';

abstract class AuthenticationMiddleware {
  static Middleware check({required App firebaseAdmin}) {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          if (request.headers.containsKey('jwt')) {
            final token = request.headers['jwt'];
            if (token == null || token.isEmpty) {
              return _getUnauthorizedResponse(request);
            } else {
              final idToken = await firebaseAdmin.auth().verifyIdToken(token);

              if (!(idToken.isVerified ?? false)) {
                return _getUnauthorizedResponse(request);
              }

              final id = idToken.claims['user_id'];
              request = request.change(
                context: {...request.context, 'user_id': id},
              );
            }

            return innerHandler(request);
          } else {
            return _getUnauthorizedResponse(request);
          }
        } catch (e) {
          return Response.badRequest(
            body: 'Error processing request: ${e.toString()}',
          );
        }
      };
    };
  }

  static Response _getUnauthorizedResponse(Request request) {
    return Response.unauthorized(
      'Request is missing jwt header: ${request.handlerPath}',
    );
  }
}
