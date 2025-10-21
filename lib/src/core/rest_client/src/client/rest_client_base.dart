import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import '../exception/rest_client_exception.dart.dart';
import 'rest_client.dart';

abstract base class RestClientBase implements RestClient {
  RestClientBase({required String baseUrl}) : baseUri = Uri.parse(baseUrl);

  final Uri baseUri;

  static final _jsonUTF8 = json.fuse(utf8);

  Future<Map<String, Object?>?> send({
    required String path,
    required String method,
    Map<String, Object?>? body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  });

  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) => send(
    path: path,
    method: 'DELETE',
    headers: headers,
    queryParams: queryParams,
  );

  @override
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) => send(
    path: path,
    method: 'GET',
    headers: headers,
    queryParams: queryParams,
  );

  @override
  Future<Map<String, Object?>?> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) => send(
    path: path,
    method: 'PATCH',
    body: body,
    headers: headers,
    queryParams: queryParams,
  );

  @override
  Future<Map<String, Object?>?> post(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) => send(
    path: path,
    method: 'POST',
    body: body,
    headers: headers,
    queryParams: queryParams,
  );

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
  }) => send(
    path: path,
    method: 'PUT',
    body: body,
    headers: headers,
    queryParams: queryParams,
  );

  Uri buildUri({required String path, Map<String, String?>? queryParams}) {
    final finalPath = p.join(baseUri.path, path);
    return baseUri.replace(
      path: finalPath,
      queryParameters: {...baseUri.queryParameters, ...?queryParams},
    );
  }

  List<int> encodeBody(Map<String, Object?> body) {
    try {
      return _jsonUTF8.encode(body);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(message: 'Error occurred during encoding', cause: e),
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
        StringResponseBody(:final data) => await _decodeString(data),
        BytesResponseBody(:final data) => await _decodeBytes(data),
      };

      if (decodedBody case {'error': final Map<String, Object?> error}) {
        throw StructuredBackendException(error: error, statusCode: statusCode);
      }

      if (decodedBody case {'data': final Map<String, Object?> data}) {
        return data;
      }

      return decodedBody;
    } on RestClientException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'Error occured during decoding',
          statusCode: statusCode,
          cause: e,
        ),
        stackTrace,
      );
    }
  }

  Future<Map<String, Object?>?> _decodeString(String stringBody) async {
    if (stringBody.isEmpty) return null;

    if (stringBody.length > 1000) {
      return (await compute(
            json.decode,
            stringBody,
            debugLabel: kDebugMode ? 'Decode String Compute' : null,
          ))
          as Map<String, Object?>;
    }

    return json.decode(stringBody) as Map<String, Object?>;
  }

  Future<Map<String, Object?>?> _decodeBytes(List<int> bytesBody) async {
    if (bytesBody.isEmpty) return null;

    if (bytesBody.length > 1000) {
      return (await compute(
            _jsonUTF8.decode,
            bytesBody,
            debugLabel: kDebugMode ? 'Decode Bytes Compute' : null,
          ))!
          as Map<String, Object?>;
    }

    return _jsonUTF8.decode(bytesBody)! as Map<String, Object?>;
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
