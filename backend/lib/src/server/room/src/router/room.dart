import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../../core/rest_api/src/rest_api.dart';
import '../../room.dart';

class RoomRouter {
  RoomRouter({
    required IRoomRepository roomRepository,
    required RestApi restApi,
  }) : _restApi = restApi,
       _roomRepository = roomRepository;
  final RestApi _restApi;
  final IRoomRepository _roomRepository;

  Handler get handler {
    final router = Router();

    router.get('/rooms/<dormitoryId>', _searchRooms);
    return router.call;
  }

  String _checkQuery(Request request) {
    final query = request.url.queryParameters['query'];
    if (query == null || query.isEmpty) {
      throw BadRequestException(
        error: {'description': 'Missing query parameter.', 'field': 'query'},
      );
    }

    return query;
  }

  int _checkDormitoryId(Request request) {
    final dormitoryId = request.params['dormitoryId'];

    if (dormitoryId == null || dormitoryId.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing path parameter.',
          'field': 'dormitoryId',
        },
      );
    } else if (int.tryParse(dormitoryId) == null) {
      throw BadRequestException(
        error: {
          'description': 'Invalid path parameter.',
          'field': 'dormitoryId',
        },
      );
    }

    return int.parse(dormitoryId);
  }

  Future<Response> _searchRooms(Request request) async {
    final dormitoryId = _checkDormitoryId(request);
    final query = _checkQuery(request);
    final rooms = await _roomRepository.searchRooms(
      query: query,
      dormitoryId: dormitoryId,
    );
    final json = rooms
        .map((room) => RoomDto.fromEntity(room).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'rooms': json},
      },
    );
  }
}
