import 'package:logger/logger.dart';

import '../../rest_client/rest_client.dart';

class LoggerMiddleware {
  const LoggerMiddleware({
    this.logRequest = false,
    this.logResponse = true,
    this.logError = true,
  });

  final bool logRequest;
  final bool logResponse;
  final bool logError;

  ApiClientHandler call(
    ApiClientHandler innerHandler,
  ) => (request, context) async {
    final stopWatch = Stopwatch()..start();
    if (logRequest) {
      Logger().i('HTTP: [${request.method}] ${request.url}', time: .now());
    }

    try {
      final response = await innerHandler(request, context);

      if (logResponse) {
        Logger().i(
          'HTTP: [${request.method}] ${request.url} -> success | ${stopWatch.elapsedMilliseconds}ms',
        );
      }

      return response;
    } on Object catch (e, s) {
      if (logError) {
        Logger().e(
          'HTTP: [${request.method}] ${request.url} | ${stopWatch.elapsedMilliseconds}ms',
          error: e,
          stackTrace: s,
        );
      }
      rethrow;
    } finally {
      stopWatch.stop();
    }
  };
}
