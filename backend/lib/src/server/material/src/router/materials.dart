import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../material.dart';

part 'materials.g.dart';

class MaterialService {
  const MaterialService({required this._restApi, required this._repository});

  Router get handler => _$MaterialServiceRouter(this);

  final RestApi _restApi;
  final IMaterialRepository _repository;

  @Route.get('/materials')
  Future<Response> getMaterials(Request request) async {
    final qp = request.url.queryParameters;
    final typeId = int.tryParse(qp['type_id'] ?? '');
    final data = await _repository.getMaterials(typeId: typeId);
    final json = data.map((e) => MaterialDto.fromEntity(e).toJson()).toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'materials': json},
      },
    );
  }
}
