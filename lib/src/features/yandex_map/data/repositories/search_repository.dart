import '../../../../core/rest_client/rest_client.dart';
import '../../model/dormitory.dart';

abstract class ISearchRepository {
  Future<List<FullDormitory>> searchDormitories({required String query});
}

class SearchRepository implements ISearchRepository {
  const SearchRepository({required RestClientHttp client}) : _client = client;
  final RestClientHttp _client;

  @override
  Future<List<FullDormitory>> searchDormitories({required String query}) async {
    final response = await _client.send(
      path: '/dormitories/$query',
      method: 'GET',
    );

    final dormitories = (response!['data']! as List)
        .map((e) => FullDormitory.fromJson(e))
        .toList();

    return dormitories;
  }
}
