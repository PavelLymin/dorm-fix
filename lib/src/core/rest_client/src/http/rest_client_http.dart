import 'dart:async';
import 'dart:convert';

import 'package:cronet_http/cronet_http.dart' show CronetClient;
import 'package:cupertino_http/cupertino_http.dart' show CupertinoClient;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:http/http.dart' as http;
import '../../rest_client.dart';
import '../exception/check_exception_io.dart';

http.Client createDefaultHttpClient() {
  http.Client? client;
  final platform = defaultTargetPlatform;

  try {
    client = switch (platform) {
      .android => CronetClient.defaultCronetEngine(),
      .iOS || .macOS => CupertinoClient.defaultSessionConfiguration(),
      _ => null,
    };
  } on Object catch (e, stackTrace) {
    Zone.current.print(
      'Failed to create a default http client for platform $platform $e $stackTrace',
    );
  }

  return client ?? http.Client();
}

final class RestClientHttp extends RestClientBase {
  RestClientHttp({required super.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<Map<String, Object?>?> send({
    required String path,
    required String method,
    Map<String, String?>? queryParams,
    Map<String, String>? headers,
    Map<String, Object?>? body,
  }) async {
    try {
      final uri = buildUri(path: path, queryParams: queryParams);
      final request = http.Request(method, uri);

      if (body != null) {
        request.bodyBytes = encodeBody(body);
        request.headers['content-type'] = 'application/json;charset=utf-8';
      }

      if (headers != null) {
        request.headers.addAll(headers);
      }

      final response = await _client
          .send(request)
          .then(http.Response.fromStream);

      final result = await decodeResponse(
        BytesResponseBody(response.bodyBytes),
        statusCode: response.statusCode,
      );

      return result;
    } on RestClientException {
      rethrow;
    } on http.ClientException catch (e, stack) {
      final checkedException = checkHttpException(e);

      if (checkedException != null) {
        Error.throwWithStackTrace(checkedException, stack);
      }

      Error.throwWithStackTrace(
        ClientException(message: e.message, cause: e),
        stack,
      );
    }
  }

  @override
  Stream<Map<String, Object?>> stream({
    required String path,
    required String method,
    Map<String, String?>? queryParams,
    Map<String, String>? headers,
  }) async* {
    try {
      final uri = buildUri(path: path, queryParams: queryParams);
      final request = http.Request(method, uri);

      if (headers != null) request.headers.addAll(headers);
      request.headers['Accept'] = 'text/event-stream';

      final streamedResponse = await _client.send(request);

      if (streamedResponse.statusCode != 200) {
        final errorBody = await streamedResponse.stream.bytesToString();
        try {
          final errorJson = jsonDecode(errorBody) as Map<String, Object?>;
          throw StructuredBackendException(
            error: errorJson,
            statusCode: streamedResponse.statusCode,
          );
        } catch (_) {
          throw ClientException(
            message: 'HTTP error ${streamedResponse.statusCode}',
            statusCode: streamedResponse.statusCode,
          );
        }
      }

      final lines = streamedResponse.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      String? currentData;
      String? currentEvent;
      await for (final line in lines) {
        if (line.startsWith('error: ')) {
          currentEvent = line.substring(7);
        } else if (line.isEmpty) {
          if (currentEvent == 'error') {
            throw Exception('SSE error: ${currentData ?? 'Unknown error'}');
          }
          if (currentData != null) {
            final jsonStr = currentData;
            currentData = null;
            currentEvent = null;
            final data = jsonDecode(jsonStr) as Map<String, Object?>;
            yield data;
          }
          currentData = null;
          currentEvent = null;
        } else if (currentData != null) {
          currentData += '\n$line';
        }
      }
    } on RestClientException {
      rethrow;
    } on http.ClientException catch (e, stack) {
      final checkedException = checkHttpException(e);
      if (checkedException != null) {
        Error.throwWithStackTrace(checkedException, stack);
      }
      Error.throwWithStackTrace(
        ClientException(message: e.message, cause: e),
        stack,
      );
    }
  }
}
