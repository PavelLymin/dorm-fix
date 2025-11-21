import 'dart:convert';

import 'package:shelf/shelf.dart';
import '../exception/rest_api_exception.dart';
import 'rest_api.dart';

base class RestApiBase implements RestApi {
  const RestApiBase();

  static final _jsonUTF8 = json.fuse(utf8);

  List<int> encodeBody(Map<String, Object?> body) {
    try {
      return _jsonUTF8.encode(body);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        BadRequestException(
          error: {
            'description': 'Error occured during encoding.',
            'details': {'body': 'Invalid JSON format.'},
          },
        ),
        stackTrace,
      );
    }
  }

  @override
  Response send({
    required int statusCode,
    Map<String, String>? headers,
    Map<String, Object?>? responseBody,
  }) {
    Response response = Response(statusCode, encoding: utf8);

    if (responseBody != null) {
      response = response.change(body: encodeBody(responseBody));
    }

    if (headers != null) {
      response.headers.addAll(headers);
    }

    return response;
  }
}
