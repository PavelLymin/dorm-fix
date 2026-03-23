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
    required this._restApi,
    required IRequestRepository requestRepository,
    required this._requestFacade,
    required WebSocketBase wsConnection,
  });

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
    await _requestFacade.createRequest(uid: uid, request: entity);

    return _restApi.send(statusCode: 201);
  }

  Future<Response> _watchRepairRequests(Request request) async {
    final qp = request.url.queryParameters;
    final useUid = bool.parse(qp['use_uid'] ?? 'false');
    final specId = int.tryParse(qp['spec_id'] ?? '');
    final dormId = int.tryParse(qp['dorm_id'] ?? '');
    final status = qp['status'];

    final uid = useUid ? RequireUser.getUserId(request) : null;

    StreamSubscription? subscription;
    final controller = StreamController(onCancel: () => subscription?.cancel());

    subscription = _requestFacade
        .watchRequests(uid: uid, specId: specId, dormId: dormId, status: status)
        .listen(
          (rows) {
            final payload = {
              'data': {
                'requests': rows
                    .map((row) => RequestAggregateDto.fromEntity(row).toJson())
                    .toList(),
              },
            };
            controller.add(utf8.encode('data: ${jsonEncode(payload)}\n\n'));
          },
          onError: (erorr) {
            controller.add(utf8.encode('error: $erorr\n\n'));
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
