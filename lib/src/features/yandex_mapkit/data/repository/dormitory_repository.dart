import 'package:dorm_fix/src/features/yandex_mapkit/data/dto/dormitory.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/rest_client/rest_client.dart';
import '../../model/dormitory.dart';

abstract class IDormitoryRepository {
  Future<List<DormitoryEntity>> searchDormitories({required String query});
  Future<List<DormitoryEntity>> getDormitories();
}

class DormitoryRepository implements IDormitoryRepository {
  const DormitoryRepository({required RestClientHttp client})
    : _client = client;
  final RestClientHttp _client;

  @override
  Future<List<DormitoryEntity>> searchDormitories({
    required String query,
  }) async {
    debugPrint('query = $query');
    final response = await _client.send(
      path: '/dormitories',
      method: 'GET',
      queryParams: {'query': query},
    );
    debugPrint(response.toString());

    final data = response?['dormitories'];

    if (data is! List) {
      throw StructuredBackendException(
        error: {'description': 'The dormitories was not found.'},
        statusCode: 404,
      );
    }

    final dormitories = data
        .map((json) => DormitoryDto.fromJson(json).toEntity())
        .toList();

    return dormitories;
  }

  @override
  Future<List<DormitoryEntity>> getDormitories() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      DormitoryEntity(
        id: 1,
        number: 30,
        name: 'Общежитие',
        address: 'address',
        long: 92.793795,
        lat: 55.995387,
      ),
      DormitoryEntity(
        id: 2,
        number: 21,
        name: 'Общежитие',
        address: 'address',
        long: 92.766513,
        lat: 56.008465,
      ),
    ];
  }
}
