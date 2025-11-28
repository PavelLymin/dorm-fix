import 'package:firebase_admin/firebase_admin.dart';
import 'package:shelf/shelf.dart';

abstract class AuthenticationMiddleware {
  static Middleware call({required App firebaseAdmin}) {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          if (request.headers.containsKey('Authorization')) {
            final token = request.headers['Authorization']
                ?.split('Bearer ')
                .last;
            if (token == null || token.isEmpty) {
              return _getUnauthorizedResponse(request);
            } else {
              final idToken = await firebaseAdmin.auth().verifyIdToken(token);

              if (!(idToken.isVerified ?? false)) {
                return _getUnauthorizedResponse(request);
              }

              final id = idToken.claims['user_id'];
              final role = idToken.claims['role'];
              request = request.change(
                context: {...request.context, 'user_id': id, 'role': role},
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
