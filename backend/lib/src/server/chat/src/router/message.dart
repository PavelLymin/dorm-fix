import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/src/require_user.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../../../core/ws/ws.dart';
import '../../chat.dart';

enum ResponseType {
  created(value: 'message_created'),
  deleted(value: 'message_deleted'),
  updated(value: 'message_updated'),
  error(value: 'message_error');

  const ResponseType({required this.value});
  final String value;

  factory ResponseType.fromValue(String type) {
    return values.firstWhere(
      (element) => element.value == type,
      orElse: () => throw FormatException('Unknown  response type: $type'),
    );
  }
}

class MessageRouter {
  const MessageRouter({
    required RestApi restApi,
    required IMessageRepository messageRepository,
    required WebSocketBase ws,
  }) : _restApi = restApi,
       _messageRepository = messageRepository,
       _ws = ws;

  final RestApi _restApi;
  final IMessageRepository _messageRepository;
  final WebSocketBase _ws;

  Handler get handler {
    final router = Router();

    router.post('/messages', _createMessage);
    router.get('/messages', _getMessages);
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

  Future<Response> _createMessage(Request request) async {
    final uid = RequireUser.getUserId(request);
    final json = await _readJson(request);
    final entity = PartialMessageDto.fromJson(json).toEntity();

    final createdMessage = await _messageRepository.createMessage(
      message: entity,
    );
    final message = FullMessageDto.fromEntity(createdMessage).toJson();
    _ws.sendToUser(ResponseType.created.value, message, uid: uid);

    return _restApi.send(
      statusCode: 201,
      responseBody: {
        'data': {'message': 'The message was successfully created.'},
      },
    );
  }

  Future<Response> _getMessages(Request request) async {
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
    final messages = await _messageRepository.getMessages(chatId: chatId);
    final messagesJson = messages
        .map((e) => FullMessageDto.fromEntity(e).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'messages': messagesJson},
      },
    );
  }
}
