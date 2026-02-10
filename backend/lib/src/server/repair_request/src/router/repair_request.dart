import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../../../core/ws/ws.dart';
import '../../repair_request.dart';

class RepairRequestRouter {
  const RepairRequestRouter({
    required RestApi restApi,
    required IRequestRepository requestRepository,
    required WebSocketBase wsConnection,
  }) : _restApi = restApi,
       _requestRepository = requestRepository,
       _wsConnection = wsConnection;

  final RestApi _restApi;
  final IRequestRepository _requestRepository;
  final WebSocketBase _wsConnection;

  Handler get handler {
    final router = Router();

    router.post('/repairRequests', _createRepairRequest);
    router.get('/repairRequests', _getRepairRequests);
    return router.call;
  }

  Future<Map<String, Object?>> _readJson(Request request) async {
    final body = await request.readAsString();
    if (body.trim().isEmpty) {
      throw BadRequestException(
        error: {'description': 'Request body is empty.', 'field': 'body'},
      );
    }
    final json = jsonDecode(body);
    return json;
  }

  Future<Response> _createRepairRequest(Request request) async {
    final uid = RequireUser.getUserId(request);
    final json = await _readJson(request);
    final entity = PartialRepairRequestDto.fromJson(json).toEntity();
    final createdRequest = await _requestRepository.createRequest(
      uid: uid,
      request: entity,
    );

    _wsConnection.sendToUser(
      uid: uid,
      envelope: MessageEnvelope(
        type: .requestCreated,
        payload: .createdRequest(request: createdRequest),
      ),
    );

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': FullRepairRequestDto.fromEntity(createdRequest).toJson(),
      },
    );
  }

  Future<Response> _getRepairRequests(Request request) async {
    final uid = RequireUser.getUserId(request);
    final requests = await _requestRepository.getRequests(uid: uid);
    final json = requests
        .map((request) => FullRepairRequestDto.fromEntity(request).toJson())
        .toList();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'repair_requests': json},
      },
    );
  }
}
