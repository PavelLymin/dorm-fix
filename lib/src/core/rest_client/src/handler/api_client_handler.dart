import 'package:http/http.dart' as http;

typedef ApiClientHandler =
    Future<http.BaseResponse> Function(http.Request request, dynamic context);

typedef ApiClientMiddleware = ApiClientHandler Function(ApiClientHandler);
