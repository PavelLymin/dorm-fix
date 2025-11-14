import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../data/dto/specialization.dart';
import '../data/repository/specialization_repository.dart';

class SpecializationRouter {
  SpecializationRouter({
    required ISpecializationRepository specializationRepository,
    required Logger logger,
  }) : _specializationRepository = specializationRepository,
       _logger = logger;

  final ISpecializationRepository _specializationRepository;
  final Logger _logger;

  Handler get handler {
    final router = Router();

    router.get('/specializations', _getSpecializations);
    return router.call;
  }

  Future<Response> _getSpecializations(Request request) async {
    try {
      final specializations = await _specializationRepository
          .getSpecializations();

      final json = specializations
          .map((spec) => SpecializationDto.fromEntity(spec).toJson())
          .toList();

      return RestApi.createResponse({
        'data': {
          'message': {'specializations': json},
        },
      }, 200);
    } on FormatException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInvalidJsonResponse();
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return RestApi.createInternalServerResponse(
        details: {'error_type': e.runtimeType.toString()},
      );
    }
  }
}
