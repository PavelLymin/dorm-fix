import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../chat.dart';

class CharRouter {
  const CharRouter({
    required RestApi restApi,
    required IChatRepository chatRepository,
    required IChatUsersRepository chatUserRepository,
  }) : _restApi = restApi,
       _chatRepository = chatRepository,
       _chatUsersRepository = chatUserRepository;

  final RestApi _restApi;
  final IChatRepository _chatRepository;
  final IChatUsersRepository _chatUsersRepository;

  Handler get handler {
    final router = Router();

    router.post('/chats', _createChat);
    router.get('/chats', _getChatByRequestId);
    router.post('/chats/members', _addMember);
    return router.call;
  }

  Future<Map<String, Object?>> _readJson(Request request) async {
    final body = await request.readAsString();
    if (body.trim().isEmpty) {
      throw BadRequestException(
        error: {'description': 'Request body is empty.', 'field': 'body'},
      );
    }

    final json = jsonDecode(body);
    return json;
  }

  Future<Response> _createChat(Request request) async {
    final uid = RequireUser.getUserId(request);
    final json = await _readJson(request);
    final entity = PartialChatDto.fromJson(json).toEntity();

    final createdChat = await _chatRepository.createChat(chat: entity);
    final chat = FullChatDto.fromEntity(createdChat).toJson();
    _chatUsersRepository.createChat(uid: uid, chat: chat);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The chat was successfully created.'},
      },
    );
  }

  Future<Response> _getChatByRequestId(Request request) async {
    final params = request.url.queryParameters;
    final requestIdParam = params['request_id'];
    if (requestIdParam == null || int.tryParse(requestIdParam) == null) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid request_id parameter.',
          'field': 'request_id',
        },
      );
    }

    final requestId = int.parse(requestIdParam);
    final chat = await _chatRepository.getChatByRequestId(requestId: requestId);
    if (chat == null) {
      throw NotFoundException(
        error: {'message': 'Chat not found for the given request_id.'},
      );
    }

    final chatJson = FullChatDto.fromEntity(chat).toJson();
    return _restApi.send(statusCode: 200, responseBody: {'data': chatJson});
  }

  Future<Response> _addMember(Request request) async {
    final uid = RequireUser.getUserId(request);
    final params = request.url.queryParameters;
    final chatIdParam = params['chat_id'];
    if (chatIdParam == null || int.tryParse(chatIdParam) == null) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid chat_id parameter.',
          'field': 'chat_id',
        },
      );
    }

    final chatId = int.parse(chatIdParam);
    await _chatRepository.addMember(chatId: chatId, uid: uid);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'Successfully joined the chat room.'},
      },
    );
  }
}
