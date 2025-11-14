import 'dart:convert';

import 'package:shelf/shelf.dart';

abstract class RestApi {
  const RestApi();

  static Response createResponse(Object data, [int statusCode = 200]) =>
      Response(
        statusCode,
        body: data,
        headers: {'Content-Type': 'application/json'},
      );

  static Response createInvalidJsonResponse({
    String? message,
    Object? details,
  }) => createResponse(
    jsonEncode({
      'error': {
        'message': message ?? 'Invalid JSON format.',
        'details': details ?? {'field': 'body'},
      },
    }),
    400,
  );

  static Response createInternalServerResponse({
    String? message,
    Object? details,
  }) => createResponse(
    jsonEncode({
      'error': {
        'message': message ?? 'Error processing request.',
        'details': details ?? {},
      },
    }),
    500,
  );
}
