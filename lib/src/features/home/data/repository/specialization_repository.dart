import '../../../../core/rest_client/rest_client.dart';
import '../../model/specialization.dart';
import '../dto/specialization.dart';

abstract interface class ISpecializationRepository {
  Future<List<SpecializationEntity>> getSpecializations();
}

class SpecializationRepositoryImpl implements ISpecializationRepository {
  SpecializationRepositoryImpl({required RestClientHttp client})
    : _client = client;
  final RestClientHttp _client;

  @override
  Future<List<SpecializationEntity>> getSpecializations() async {
    final response = await _client.send(
      path: '/specializations',
      method: 'GET',
    );

    if (response == null) return [];

    final data = response['data'] as List;
    final specializations = data
        .map((json) => SpecializationDto.fromJson(json).toEntity())
        .toList();

    return specializations;
  }
}
