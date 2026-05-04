import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/rest_api.dart';
import '../../repair_request.dart';
import '../model/status.dart';

part 'repair_requests.g.dart';

class RepairRequests {
  const RepairRequests({required this._restApi, required this._requestFacade});

  Router get handler => _$RepairRequestsRouter(this);

  final RestApi _restApi;
  final IRepairRequestFacade _requestFacade;

  @Route.post('/requests/<id>/update-status')
  Future<Response> _updateRepairRequestStatus(
    Request request,
    String id,
  ) async {
    final status = await request.body(StatusEnum.fromJson);
    await _requestFacade.updateStatus(
      masterUid: request.userId,
      requestId: int.parse(id),
      status: status,
    );

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'message': 'Successfully accepted the request.'},
      },
    );
  }

  @Route.post('/requests/<id>/accept')
  Future<Response> _acceptRepairRequest(Request request, String id) async {
    await _requestFacade.acceptRequest(
      masterUid: request.userId,
      requestId: int.parse(id),
    );

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'Successfully accepted the request.'},
      },
    );
  }

  @Route.post('/requests/<id>/complete')
  Future<Response> _completeRepairRequest(Request request, String id) async {
    final body = await request.body((json) {
      if (json['material_usage'] case List<Object?> materialUsage) {
        return {
          for (final item in materialUsage)
            if (item case <String, Object?>{
              'material_id': int materialId,
              'quantity': int quantity,
            })
              materialId: quantity,
        };
      }

      return null;
    });

    await _requestFacade.completeRequest(
      masterUid: request.userId,
      requestId: int.parse(id),
      materialUsage: body,
    );

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'Successfully completed the request.'},
      },
    );
  }

  @Route.post('/requests')
  Future<Response> _createRepairRequest(Request request) async {
    final dto = await request.body(PartialRepairRequestDto.fromJson);
    final result = await _requestFacade.createRequest(
      uid: request.userId,
      req: dto.toEntity(),
    );

    final data = FullRepairRequestDto.fromEntity(result).toJson();

    return _restApi.send(statusCode: 201, responseBody: {'data': data});
  }

  @Route.get('/requests/stream')
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
                    .map((row) => FullRepairRequestDto.fromEntity(row).toJson())
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
        'Content-Type': 'text/event-stream; charset=utf-8',
        'Cache-Control': 'no-cache, no-transform',
        'Connection': 'keep-alive',
        'X-Accel-Buffering': 'no',
      },
      context: {'shelf.io.buffer_output': false},
    );
  }
}
