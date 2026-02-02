import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import '../rest_api/src/rest_api.dart';

abstract class ErrorMiddleware {
  static Middleware call(Logger logger, RestApi restApi) {
    return createMiddleware(
      errorHandler: (error, stackTrace) {
        logger.e('Error occurred', error: error, stackTrace: stackTrace);
        return switch (error) {
          RestApiException ex => restApi.send(
            statusCode: ex.statusCode,
            responseBody: ex.toJson(),
          ),
          _ => restApi.send(
            statusCode: 500,
            responseBody: {
              'message': 'Error processing request.',
              'error': {'details': {}},
            },
          ),
        };
      },
    );
  }
}
