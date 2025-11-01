import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/building.dart';
import '../data/repository/dormitory_repository.dart';

class BuildingRouter {
  BuildingRouter({required IBuildingRepository buildingRepository})
    : _buildingRepository = buildingRepository;

  final IBuildingRepository _buildingRepository;

  Handler get handler {
    final router = Router();

    router.get('/buildings', _search);
    return router.call;
  }

  Future<Response> _search(Request request) async {
    try {
      final query = request.url.queryParameters['query'];

      if (query == null || query.isEmpty) {
        return Response.badRequest(body: 'Missing query parameter "query"');
      }

      final buildings = await _buildingRepository.search(query: query);

      final json = buildings
          .map((building) => BuildingDto.fromEntity(building).toJson())
          .toList();

      return Response.ok(jsonEncode(json));
    } on FormatException catch (e) {
      return Response.badRequest(body: 'Invalid JSON format: ${e.toString()}');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}',
      );
    }
  }
}
