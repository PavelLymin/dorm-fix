import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/src/rest_api.dart';
import '../../chat.dart';

class MessageRouter {
  const MessageRouter({
    required RestApi restApi,
    required IMessageRepository messageRepository,
  }) : _restApi = restApi,
       _messageRepository = messageRepository;

  final RestApi _restApi;
  final IMessageRepository _messageRepository;

  Handler get handler {
    final router = Router();

    router.get('/messages', _getMessages);
    return router.call;
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
        .map((e) => MessageDto.fromEntity(e).toJson())
        .toList();
    return _restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'messages': messagesJson},
      },
    );
  }
}
