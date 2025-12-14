import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../../../core/ws/ws.dart';
import '../../request.dart';

enum ResponseType {
  created(value: 'created'),
  deleted(value: 'deleted'),
  updated(value: 'updated'),
  error(value: 'error');

  const ResponseType({required this.value});
  final String value;

  factory ResponseType.fromValue(String type) {
    return ResponseType.values.firstWhere(
      (element) => element.value == type,
      orElse: () => throw ArgumentError('Unknown  response type: $type'),
    );
  }
}

class RequestRouter {
  RequestRouter({
    required RestApi restApi,
    required IRequestRepository requestRepository,
    required WsConnection wsConnection,
  }) : _restApi = restApi,
       _requestRepository = requestRepository,
       _wsConnection = wsConnection;

  final RestApi _restApi;
  final IRequestRepository _requestRepository;
  final WsConnection _wsConnection;

  Handler get handler {
    final router = Router();

    router.post('/requests', _createRequest);
    router.get('/requests', _getRequests);
    return router.call;
  }

  Future<Map<String, dynamic>> _readJson(Request request) async {
    final body = await request.readAsString();
    if (body.trim().isEmpty) {
      throw BadRequestException(
        error: {'description': 'Request body is empty.', 'field': 'body'},
      );
    }
    final json = jsonDecode(body);
    return json;
  }

  Future<Response> _createRequest(Request request) async {
    final uid = RequireUser.getUserId(request);
    final json = await _readJson(request);

    final entity = CreatedRequestDto.fromJson(json).toEntity();
    final createdRequest = await _requestRepository.createRequest(
      uid: uid,
      request: entity,
    );

    final message = FullRequestDto.fromEntity(createdRequest).toJson();
    _wsConnection.sendToUser(
      uid: uid,
      message: {'type': ResponseType.created.value, 'payload': message},
    );

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The request was successfully created.'},
      },
    );
  }

  Future<Response> _getRequests(Request request) async {
    final uid = RequireUser.getUserId(request);
    final requests = await _requestRepository.getRequests(uid: uid);
    final json = requests
        .map((request) => FullRequestDto.fromEntity(request).toJson())
        .toList();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'requests': json},
      },
    );
  }
}
