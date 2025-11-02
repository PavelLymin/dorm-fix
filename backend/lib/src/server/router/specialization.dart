import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/specialization.dart';
import '../data/repository/specialization_repository.dart';

class SpecializationRouter {
  SpecializationRouter({
    required ISpecializationRepository specializationRepository,
  }) : _specializationRepository = specializationRepository;

  final ISpecializationRepository _specializationRepository;

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
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }
}
