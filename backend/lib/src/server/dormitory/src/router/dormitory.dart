import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../dormitory.dart';

class DormitoryRouter {
  DormitoryRouter({
    required RestApi restApi,
    required IDormitoryRepository dormitoryRepository,
  }) : _restApi = restApi,
       _dormitoryRepository = dormitoryRepository;

  final RestApi _restApi;
  final IDormitoryRepository _dormitoryRepository;

  Handler get handler {
    final router = Router();

    router.get('/dormitories/search', _search);
    router.get('/dormitories', _getDormitories);
    return router.call;
  }

  String _checkQuery(Request request) {
    final query = request.url.queryParameters['query'];
    if (query == null || query.isEmpty) {
      throw BadRequestException(
        error: {
          'description': 'Missing query parameter "query',
          'field': 'query',
        },
      );
    }

    return query;
  }

  Future<Response> _search(Request request) async {
    final query = _checkQuery(request);
    final dormitories = await _dormitoryRepository.search(query: query);
    final json = dormitories
        .map((dormitory) => DormitoryDto.fromEntity(dormitory).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'dormitories': json},
      },
    );
  }

  Future<Response> _getDormitories(Request request) async {
    final dormitories = await _dormitoryRepository.getDormitories();
    final json = dormitories
        .map((dormitory) => DormitoryDto.fromEntity(dormitory).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'dormitories': json},
      },
    );
  }
}
