import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/dormitory.dart';
import '../data/repository/dormitory_repository.dart';

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

    router.get('/dormitories', _search);
    return router.call;
  }

  String _checkQuery(Request request) {
    final query = request.url.queryParameters['query'];

    if (query == null || query.isEmpty) {
      throw BadRequestException(
        message: 'Missing query parameter "query".',
        error: {'field': 'query'},
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
}
