import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';

abstract class ErrorMiddleware {
  static Middleware call(Logger logger, RestApi restApi) {
    // return (Handler innerHandler) {
    //   return (Request request) {
    //     try {
    //       return innerHandler(request);
    //     } catch (error) {
    //       logger.e('Error occurred', error: error);
    //       return switch (error) {
    //         RestApiException ex => restApi.send(
    //           statusCode: ex.statusCode,
    //           responseBody: ex.toJson(),
    //         ),
    //         FormatException _ => _createInvalidJsonResponse(restApi: restApi),
    //         TypeError _ => _createInvalidJsonResponse(
    //           restApi: restApi,
    //           message: 'Invalid input type.',
    //         ),
    //         _ => _createInternalServerResponse(restApi: restApi),
    //       };
    //     }
    //   };
    // };
    return createMiddleware(
      errorHandler: (error, stackTrace) {
        logger.e('Error occurred', error: error, stackTrace: stackTrace);

        return switch (error) {
          RestApiException ex => restApi.send(
            statusCode: ex.statusCode,
            responseBody: ex.toJson(),
          ),
          FormatException _ => _createInvalidJsonResponse(restApi: restApi),
          TypeError _ => _createInvalidJsonResponse(
            restApi: restApi,
            message: 'Invalid input type.',
          ),
          _ => _createInternalServerResponse(restApi: restApi),
        };
      },
    );
  }

  static Response _createInvalidJsonResponse({
    required RestApi restApi,
    String? message,
    Object? details,
  }) => restApi.send(
    statusCode: 400,
    responseBody: {
      'message': message ?? 'Invalid JSON format.',
      'error': {
        'details': details ?? {'field': 'body'},
      },
    },
  );

  static Response _createInternalServerResponse({
    required RestApi restApi,
    String? message,
    Object? details,
  }) => restApi.send(
    statusCode: 500,
    responseBody: {
      'message': message ?? 'Error processing request.',
      'error': details ?? {'details': {}},
    },
  );
}
