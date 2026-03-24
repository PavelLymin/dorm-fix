import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../../core/rest_api/src/rest_api.dart';
import '../../room.dart';

class RoomRouter {
  RoomRouter({required this._roomRepository, required this._restApi});
  final RestApi _restApi;
  final IRoomRepository _roomRepository;

  Handler get handler {
    final router = Router();

    router.get('/rooms/<dormitoryId>', _getRooms);
    return router.call;
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
    }
    if (int.tryParse(dormitoryId) == null) {
      throw BadRequestException(
        error: {
          'description': 'Invalid path parameter.',
          'field': 'dormitoryId',
        },
      );
    }

    return .parse(dormitoryId);
  }

  Future<Response> _getRooms(Request request) async {
    final dormitoryId = _checkDormitoryId(request);
    final query = request.url.queryParameters['query'];

    late List<RoomEntity> rooms;
    if (query == null || query.isEmpty) {
      rooms = await _roomRepository.getRooms(dormitoryId: dormitoryId);
    } else {
      rooms = await _roomRepository.searchRooms(
        query: query,
        dormitoryId: dormitoryId,
      );
    }

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
