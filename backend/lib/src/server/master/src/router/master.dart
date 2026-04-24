import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../master.dart';

class MasterRouter {
  const MasterRouter({required this._restApi, required this._masterRepository});

  final RestApi _restApi;
  final IMasterRepository _masterRepository;

  Handler get handler {
    final router = Router();

    router.get('/masters', _getMasters);

    return router.call;
  }

  Future<Response> _getMasters(Request request) async {
    final qp = request.url.queryParameters;
    final dormId = int.tryParse(qp['dorm_id'] ?? '');
    final specId = int.tryParse(qp['spec_id'] ?? '');
    final result = await _masterRepository.getMasters(
      dormId: dormId,
      specId: specId,
    );

    final json = result.map((e) => MasterDto.fromEntity(e).toJson()).toList();

    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'masters': json},
      },
    );
  }
}
