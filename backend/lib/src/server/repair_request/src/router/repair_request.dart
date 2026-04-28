import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../repair_request.dart';

part 'repair_request.g.dart';

class RepairRequests {
  const RepairRequests({required this._restApi, required this._requestFacade});

  Router get handler => _$RepairRequestsRouter(this);

  final RestApi _restApi;
  final IRepairRequestFacade _requestFacade;

  // Handler get handler {
  //   final router = Router();
  //   router.post('/requests/{id}/accept', _acceptRepairRequest);
  //   router.post('/requests', _createRepairRequest);
  //   router.get('/requests/stream', _watchRepairRequests);
  //   return router.call;
  // }

  @Route.post('/requests')
  Future<Response> _createRepairRequest(Request request) async {
    final dto = await request.body(PartialRepairRequestDto.fromJson);
    final result = await _requestFacade.createRequest(
      uid: request.userId,
      req: dto.toEntity(),
    );

    final data = FullRepairRequestDto.fromEntity(result).toJson();

    return _restApi.send(statusCode: 200, responseBody: {'data': data});
  }

  @Route.post('/requests/<id>/accept')
  Future<Response> _acceptRepairRequest(Request request, String id) async {
    await _requestFacade.acceptRequest(
      masterUid: request.userId,
      requestId: int.parse(id),
    );

    return _restApi.send(statusCode: 200, responseBody: {'data': null});
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

extension RequestContextExtension on Request {
  String get userId {
    final uid = context['user_id'];
    if (uid is! String || uid.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid user id in request context.',
          'context': 'user_id',
        },
      );
    }

    return uid;
  }
}

extension RequestBodyExtension on Request {
  Future<T> body<T>(T Function(Map<String, Object?>) fromJson) async {
    final payload = await readAsString();
    final json = jsonDecode(payload) as Map<String, Object?>;
    return fromJson(json);
  }
}
