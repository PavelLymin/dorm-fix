import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/api/rest_api.dart';
import '../../specialization.dart';

class SpecializationRouter {
  SpecializationRouter({
    required RestApi restApi,
    required ISpecializationRepository specializationRepository,
  }) : _restApi = restApi,
       _specializationRepository = specializationRepository;

  final RestApi _restApi;
  final ISpecializationRepository _specializationRepository;

  Handler get handler {
    final router = Router();

    router.get('/specializations', _getSpecializations);
    return router.call;
  }

  Future<Response> _getSpecializations(Request request) async {
    final specializations = await _specializationRepository
        .getSpecializations();
    final json = specializations
        .map((spec) => SpecializationDto.fromEntity(spec).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'specializations': json},
      },
    );
  }
}
