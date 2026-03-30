import '../../rest_client/rest_client.dart';

class AuthenticatedMiddleware {
  const AuthenticatedMiddleware({required this.getToken, required this.logout});

  final Future<String?> Function() getToken;

  final Future<void> Function() logout;

  ApiClientHandler call(ApiClientHandler innerHandler) =>
      (request, context) async {
        try {
          final token = await getToken();
          if (token == null || token.isEmpty) {
            throw Exception('Authentication token is null or empty');
          }
          request.headers['Authorization'] = 'Bearer $token';
        } on Object {
          await logout();
          rethrow;
        }

        try {
          return await innerHandler(request, context);
        } on RestClientException catch (e) {
          final logoutStatusCodes = [401, 403];
          if (logoutStatusCodes.contains(e.statusCode)) await logout();
          rethrow;
        }
      };
}
