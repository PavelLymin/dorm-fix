import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../chat.dart';

abstract interface class IChatRepository {
  Future<void> createChat({required PartialChat chat});

  Future<FullChat> getChatByRequestId({required int requestId});

  Future<void> addMember({required int chatId});
}

class ChatRepositoryImpl implements IChatRepository {
  const ChatRepositoryImpl({
    required RestClientHttp client,
    required FirebaseAuth firebaseAuth,
  }) : _client = client,
       _firebaseAuth = firebaseAuth;

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> createChat({required PartialChat chat}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final body = ChatDto.fromEntity(chat).toJson();
    await _client.send(
      path: '/chats',
      method: 'POST',
      body: body,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  @override
  Future<FullChat> getChatByRequestId({required int requestId}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/chats',
      method: 'GET',
      queryParams: {'request_id': requestId.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response case Map<String, Object?> json) {
      final chat = ChatDto.fromJson(json).toEntity() as FullChat;
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
