import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../rest_client.dart';
import '../exception/check_exception_io.dart';

const String _contentTypeJson = 'application/json;charset=utf-8';
const String _methodGet = 'GET';
const String _acceptEventStream = 'text/event-stream';
const String _cacheControlNoCache = 'no-cache';
const String _dataPrefix = 'data: ';
const String _errorPrefix = 'error: ';

http.Client createDefaultHttpClient() => http.Client();

final class RestClientHttp extends RestClientBase {
  RestClientHttp({
    required super.baseUrl,
    http.Client? client,
    List<ApiClientMiddleware>? middleware,
  }) : _client = client ?? http.Client(),
       middleware = middleware ?? [];

  final http.Client _client;
  final List<ApiClientMiddleware> middleware;

  ApiClientHandler _applyMiddleware() {
    ApiClientHandler handler = (request, context) =>
        _client.send(request).then(http.Response.fromStream);

    for (final mw in middleware) {
      handler = mw(handler);
    }

    return handler;
  }

  ApiClientHandler _applyMiddlewareStrem() {
    ApiClientHandler handler = (request, context) => _client.send(request);

    for (final mw in middleware) {
      handler = mw(handler);
    }

    return handler;
  }

  Future<http.BaseResponse> _sendWithMiddleware(http.Request request) async {
    final handler = _applyMiddleware();
    return handler(request, null);
  }

  Never _handleHttpException(http.ClientException e, StackTrace stack) {
    final checkedException = checkHttpException(e);

    if (checkedException != null) {
      Error.throwWithStackTrace(checkedException, stack);
    }

    Error.throwWithStackTrace(
      ClientException(message: e.message, cause: e),
      stack,
    );
  }

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
        request.headers['content-type'] = _contentTypeJson;
      }

      if (headers != null) request.headers.addAll(headers);

      final response = await _sendWithMiddleware(request);
      if (response is! http.Response) {
        throw ClientException(
          message: 'Expected Response but got ${response.runtimeType}',
        );
      }

      final result = await decodeResponse(
        BytesResponseBody(response.bodyBytes),
        statusCode: response.statusCode,
      );

      return result;
    } on RestClientException {
      rethrow;
    } on http.ClientException catch (e, stack) {
      _handleHttpException(e, stack);
    }
  }

  void _processSseLine(
    String line,
    StringBuffer buffer,
    StreamController<Map<String, Object?>> streamController,
  ) {
    if (line.isEmpty) {
      _flushBuffer(buffer, streamController);
      return;
    }

    if (line.startsWith(_dataPrefix)) {
      buffer.write(line.substring(_dataPrefix.length).trim());
    } else if (line.startsWith(_errorPrefix)) {
      streamController.addError(
        ClientException(message: line.substring(_errorPrefix.length).trim()),
      );
    }
  }

  void _flushBuffer(
    StringBuffer buffer,
    StreamController<Map<String, Object?>> streamController,
  ) {
    if (buffer.isEmpty) return;

    try {
      final json = jsonDecode(buffer.toString()) as Map<String, Object?>;
      streamController.add(json);
    } catch (e) {
      streamController.addError(e);
    } finally {
      buffer.clear();
    }
  }

  StreamSubscription<String> _setupStreamListener(
    http.StreamedResponse response,
    StreamController<Map<String, Object?>> streamController,
  ) {
    final buffer = StringBuffer();

    return response.stream
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen(
          (line) => _processSseLine(line, buffer, streamController),
          onError: (error) {
            streamController.addError(error);
          },
          onDone: () {
            _flushBuffer(buffer, streamController);
            streamController.close();
          },
          cancelOnError: false,
        );
  }

  @override
  Stream<Map<String, Object?>> stream({
    required String path,
    Map<String, String?>? queryParams,
    Map<String, String>? headers,
  }) {
    try {
      final uri = buildUri(path: path, queryParams: queryParams);
      final request = http.Request(_methodGet, uri);

      request.headers.addAll({
        ...?headers,
        'Accept': _acceptEventStream,
        'Cache-Control': _cacheControlNoCache,
      });
      StreamSubscription<String>? subscription;

      final streamController = StreamController<Map<String, Object?>>(
        onCancel: () => subscription?.cancel(),
      );

      final handler = _applyMiddlewareStrem();
      handler(request, null)
          .then((baseResponse) {
            if (baseResponse is! http.StreamedResponse) {
              streamController.addError(
                ClientException(
                  message:
                      'Expected StreamedResponse but got ${baseResponse.runtimeType}',
                ),
              );
              streamController.close();
              return;
            }
            subscription = _setupStreamListener(baseResponse, streamController);
          })
          .catchError((error) {
            if (!streamController.isClosed) {
              streamController.addError(error);
              streamController.close();
            }
          });

      return streamController.stream;
    } on RestClientException {
      rethrow;
    } on http.ClientException catch (e, stack) {
      _handleHttpException(e, stack);
    }
  }
}
