import 'dart:async';
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
    required IRepairRequestFacade requestFacade,
    required WebSocketBase wsConnection,
  }) : _restApi = restApi,
       _requestFacade = requestFacade;

  final RestApi _restApi;
  final IRepairRequestFacade _requestFacade;

  Handler get handler {
    final router = Router();

    router.post('/requests', _createRepairRequest);
    router.get('/requests/stream', _watchRepairRequests);
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
    final createdRequest = await _requestFacade.createRequest(
      uid: uid,
      request: entity,
    );

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': RequestAggregateDto.fromEntity(createdRequest).toJson(),
      },
    );
  }

  Future<Response> _watchRepairRequests(Request request) async {
    final uid = RequireUser.getUserId(request);

    late final StreamSubscription<List<RequestAggregate>> subscription;
    final controller = StreamController<List<int>>(
      onCancel: () => subscription.cancel(),
    );

    subscription = _requestFacade
        .watchStudentRequests(uid: uid)
        .listen(
          (requests) {
            final jsonList = requests
                .map((r) => RequestAggregateDto.fromEntity(r).toJson())
                .toList();
            final data = jsonEncode({'repair_requests': jsonList});
            controller.add(utf8.encode('$data\n\n'));
          },
          onError: (error) {
            controller.add(utf8.encode('error: $error\n\n'));
            controller.close();
          },
          onDone: () => controller.close(),
        );

    return Response.ok(
      controller.stream,
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
      },
      context: {'shelf.io.buffer_output': false},
    );
  }
}
