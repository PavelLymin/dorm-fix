import 'dart:convert';
import 'package:backend/src/server/data/dto/request.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/auth/src/require_user.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../data/repository/request_repository.dart';

class RequestRouter {
  RequestRouter({
    required RestApi restApi,
    required IRequestRepository requestRepository,
  }) : _restApi = restApi,
       _requestRepository = requestRepository;

  final RestApi _restApi;
  final IRequestRepository _requestRepository;

  Handler get handler {
    final router = Router();

    router.post('/requests', _createRequest);
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

    final createdRequest = CreatedRequestDto.fromJson(json).toEntity();
    await _requestRepository.createRequest(request: createdRequest, uid: uid);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The request was successfully created.'},
      },
    );
  }
}
