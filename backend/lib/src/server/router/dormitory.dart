import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../data/dto/dormitory.dart';
import '../data/repository/dormitory_repository.dart';

class DormitoryRouter {
  DormitoryRouter({required IDormitoryRepository dormitoryRepository})
    : _dormitoryRepository = dormitoryRepository;

  final IDormitoryRepository _dormitoryRepository;

  Handler get handler {
    final router = Router();

    router.get('/dormitories', _search);
    return router.call;
  }

  Future<Response> _search(Request request) async {
    try {
      final query = request.url.queryParameters['query'];

      if (query == null || query.isEmpty) {
        return Response.badRequest(body: 'Missing query parameter "query".');
      }

      final dormitories = await _dormitoryRepository.search(query: query);

      final json = dormitories
          .map((dormitory) => DormitoryDto.fromEntity(dormitory).toJson())
          .toList();

      return Response.ok(jsonEncode({'data': json}));
    } on FormatException catch (e) {
      return Response.badRequest(body: 'Invalid JSON format: ${e.toString()}.');
    } catch (e) {
      return Response.internalServerError(
        body: 'Error processing request: ${e.toString()}.',
      );
    }
  }
}
