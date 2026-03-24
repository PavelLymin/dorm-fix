import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../dormitory.dart';

class DormitoryRouter {
  DormitoryRouter({required this._restApi, required this._dormitoryRepository});

  final RestApi _restApi;
  final IDormitoryRepository _dormitoryRepository;

  Handler get handler {
    final router = Router();

    router.get('/dormitories', _getDormitories);
    return router.call;
  }

  Future<Response> _getDormitories(Request request) async {
    final query = request.url.queryParameters['query'];

    late List<DormitoryEntity> dormitories;

    if (query == null || query.isEmpty) {
      dormitories = await _dormitoryRepository.getDormitories();
    } else {
      dormitories = await _dormitoryRepository.searchDormitories(query: query);
    }

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
