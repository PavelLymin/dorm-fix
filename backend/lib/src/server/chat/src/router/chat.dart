import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/rest_api/rest_api.dart';
import '../../chat.dart';

class CharRouter {
  const CharRouter({required this._restApi, required this._chatRepository});

  final RestApi _restApi;
  final IChatRepository _chatRepository;

  Handler get handler {
    final router = Router();

    router.get('/chats', _getChatByRequestId);
    router.post('/chats/members', _addMember);
    return router.call;
  }

  Future<Response> _getChatByRequestId(Request request) async {
    final params = request.url.queryParameters;
    final idParam = params['id'];
    if (idParam == null || int.tryParse(idParam) == null) {
      throw BadRequestException(
        error: {
          'description': 'Missing or invalid id parameter.',
          'field': 'id',
        },
      );
    }

    final id = int.parse(idParam);
    final chat = await _chatRepository.getChat(id: id);
    if (chat == null) {
      throw NotFoundException(
        error: {'message': 'Chat not found for the given id.'},
      );
    }

    final chatJson = ChatDto.fromEntity(chat).toJson();
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
