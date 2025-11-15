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
          message: 'Error occurred during encoding',
          error: {
            'details': {'body': 'Invalid JSON format.'},
          },
        ),
        stackTrace,
      );
    }
  }

  Future<Map<String, Object?>?> decodeResponse(
    ResponseBody<Object>? body, {
    int? statusCode,
  }) async {
    if (body == null) return null;

    try {
      final decodedBody = switch (body) {
        MapResponseBody(:final data) => data,
        StringResponseBody(:final data) =>
          json.decode(data) as Map<String, Object?>,
        BytesResponseBody(:final data) =>
          _jsonUTF8.decode(data)! as Map<String, Object?>,
      };

      if (decodedBody case {'data': final Map<String, Object?> data}) {
        return data;
      }

      return decodedBody;
    } on RestApiException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        InternalServerException(
          message: 'Error occured during decoding.',
          error: {
            'details': {'response': 'Invalid JSON format.'},
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

sealed class ResponseBody<T> {
  const ResponseBody(this.data);

  final T data;
}

class StringResponseBody extends ResponseBody<String> {
  const StringResponseBody(super.data);
}

class MapResponseBody extends ResponseBody<Map<String, Object?>> {
  const MapResponseBody(super.data);
}

class BytesResponseBody extends ResponseBody<List<int>> {
  const BytesResponseBody(super.data);
}
