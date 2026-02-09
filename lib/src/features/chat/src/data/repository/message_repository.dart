import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/rest_client/rest_client.dart';
import '../../../chat.dart';

abstract interface class IMessageRepository {
  Future<List<FullMessage>> getMessages({required int chatId});
}

class MessageRepositoryImpl implements IMessageRepository {
  const MessageRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<FullMessage>> getMessages({required int chatId}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/messages',
      method: 'GET',
      queryParams: {'chat_id': chatId.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['messages'];
    if (data case List<Object?> json) {
      final messages = json
          .whereType<Map<String, Object?>>()
          .map((json) => MessageDto.fromJson(json).toEntity() as FullMessage)
          .toList();
      return messages;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
