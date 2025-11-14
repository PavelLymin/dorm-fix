import 'package:backend/src/core/rest_api/src/rest_api.dart';
import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/dormitory.dart';
import '../data/repository/dormitory_repository.dart';

class DormitoryRouter {
  DormitoryRouter({
    required IDormitoryRepository dormitoryRepository,
    required Logger logger,
  }) : _dormitoryRepository = dormitoryRepository,
       _logger = logger;

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;

  Handler get handler {
    final router = Router();

    router.get('/dormitories', _search);
    return router.call;
  }

  String _checkQuery(Request request) {
    final query = request.url.queryParameters['query'];

    if (query == null || query.isEmpty) {
      throw ValidateException(
        message: 'Missing query parameter "query".',
        details: {'field': 'query'},
      );
    }

    return query;
  }

  Future<Response> _search(Request request) async {
    try {
      final query = _checkQuery(request);

      final dormitories = await _dormitoryRepository.search(query: query);

      final json = dormitories
          .map((dormitory) => DormitoryDto.fromEntity(dormitory).toJson())
          .toList();

      return RestApi.createResponse({
        'data': {
          'message': {'specializations': json},
        },
      }, 200);
    } on RestApiException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createResponse(e.toJson(), e.statusCode);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }
}
