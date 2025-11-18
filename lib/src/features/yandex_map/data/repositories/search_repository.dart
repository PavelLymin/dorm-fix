import '../../../../core/rest_client/rest_client.dart';
import '../../model/dormitory.dart';

abstract class ISearchRepository {
  Future<List<Dormitory>> searchDormitories({required String query});
}

class SearchRepository implements ISearchRepository {
  const SearchRepository({required RestClientHttp client}) : _client = client;
  final RestClientHttp _client;

  @override
  Future<List<Dormitory>> searchDormitories({required String query}) async {
    final response = await _client.send(
      path: '/dormitories',
      method: 'GET',
      queryParams: {'query': query},
    );

    // print(response);

    final dormitories = (response!['dormitories']! as List)
        .map((e) => Dormitory.fromJson(e))
        .toList();
    print('dormitories $dormitories');

    return dormitories;
  }
}
