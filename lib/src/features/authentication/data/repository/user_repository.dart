import '../../../../core/rest_client/rest_client.dart';

abstract interface class IUserRepository {
  Future<bool> checkUserByUid({required String uid});

  Future<bool> checkUserByEmail({required String email});
}

class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl({required RestClientHttp client}) : _client = client;

  final RestClientHttp _client;

  @override
  Future<bool> checkUserByEmail({required String email}) async {
    final response = await _client.send(path: '/users/$email', method: 'GET');

    final data = response?['data'];

    if (data == null) {
      throw StructuredBackendException(
        error: {'message': 'Invalid JSON format'},
        statusCode: response?['statusCode'] as int?,
      );
    }

    return true;
  }

  @override
  Future<bool> checkUserByUid({required String uid}) async {
    final response = await _client.send(path: '/users/$uid', method: 'GET');

    if (response?['data'] == null) return false;

    return true;
  }
}
