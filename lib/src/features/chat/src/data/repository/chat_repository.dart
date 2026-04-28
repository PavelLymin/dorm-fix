import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../chat.dart';

abstract interface class IChatRepository {
  Future<ChatEntity> getChat({required int id});

  Future<void> addMember({required int chatId});
}

class ChatRepositoryImpl implements IChatRepository {
  const ChatRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<ChatEntity> getChat({required int id}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/chats',
      method: 'GET',
      queryParams: {'id': id.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response case Map<String, Object?> json) {
      final chat = ChatDto.fromJson(json).toEntity();
      return chat;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }

  @override
  Future<void> addMember({required int chatId}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    await _client.send(
      path: '/chats',
      method: 'POST',
      queryParams: {'chat_id': chatId.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
