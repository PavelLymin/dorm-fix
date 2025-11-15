import 'package:shelf/shelf.dart';

abstract interface class RestApi {
  Response send({
    required int statusCode,
    Map<String, String>? headers,
    Map<String, Object?>? responseBody,
  });
}
