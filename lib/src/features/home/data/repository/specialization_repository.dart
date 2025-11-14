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
    try {
      final response = await _client.send(
        path: '/specializations',
        method: 'GET',
      );

      final data = response?['specializations'];

      if (data is! List) {
        throw StructuredBackendException(
          error: {'message': 'Invalid JSON format'},
          statusCode: response?['statusCode'] as int?,
        );
      }

      final specializations = data
          .map((json) => SpecializationDto.fromJson(json).toEntity())
          .toList();

      return specializations;
    } on StructuredBackendException catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
