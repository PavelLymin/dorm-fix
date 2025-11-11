import 'dart:convert';
import 'package:logger/web.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
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
          .map(
            (specialization) =>
                SpecializationDto.fromEntity(specialization).toJson(),
          )
          .toList();

      return Response.ok(jsonEncode({'data': json}));
    } on FormatException catch (e) {
      return Response.badRequest(body: 'Invalid JSON format: ${e.toString()}');
    } catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }
}
