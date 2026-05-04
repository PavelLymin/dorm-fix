import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/rest_api.dart';
import '../../material.dart';

part 'materials.g.dart';

class MaterialService {
  const MaterialService({
    required this._restApi,
    required this._repositoryType,
    required this._repository,
  });

  Router get handler => _$MaterialServiceRouter(this);

  final RestApi _restApi;
  final IMaterialRepository _repository;
  final IMaterialTypeRepository _repositoryType;

  @Route.get('/materials')
  Future<Response> getMaterials(Request request) async {
    final qp = request.url.queryParameters;
    final typeId = int.tryParse(qp['type_id'] ?? '');
    final query = qp['query'];
    final data = await _repository.getMaterials(
      typeId: typeId,
      searchQuery: query,
    );
    final json = data.map((e) => MaterialDto.fromEntity(e).toJson()).toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'materials': json},
      },
    );
  }

  @Route.get('/material-types')
  Future<Response> getMaterialTypes(Request request) async {
    final data = await _repositoryType.getMaterialTypes();
    final json = data
        .map((e) => MaterialTypeDto.fromEntity(e).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'material_types': json},
      },
    );
  }

  @Route.post('/materials/<id>/consume')
  Future<Response> consumeMaterial(Request request, String id) async {
    final quantity = await request.body((json) {
      if (json case <String, Object?>{'quantity': int quantity}) {
        return quantity;
      }

      throw BadRequestException(
        error: {'description': 'Invalid quantity', 'field': 'quantity'},
      );
    });

    final materialId = int.tryParse(id);
    if (materialId == null) {
      throw BadRequestException(
        error: {'description': 'Invalid material ID', 'field': 'id'},
      );
    }

    await _repository.consumeMaterial(materialId, quantity);
    return _restApi.send(
      statusCode: 201,
      responseBody: {'data': 'Material consumed successfully'},
    );
  }
}
