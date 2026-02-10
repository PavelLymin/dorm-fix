import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../core/ws/ws.dart';
import '../../../chat.dart';
import '../../model/message_response.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> with _SetStateMixin {
  ChatBloc({
    required IWebSocket webSocket,
    required Logger logger,
    required IMessageRepository messageRepository,
    required IMessageRealtimeRepository messageRealTimeRepository,
  }) : _webSocket = webSocket,
       _logger = logger,
       _messageRepository = messageRepository,
       _messageRealTimeRepository = messageRealTimeRepository,
       super(const .loading(messages: [])) {
    _streamSubscription = _webSocket.stream.listen((message) {
      final payload = message.payload;
      log(payload.toString());
      if (payload is! MessagePayload) return;

      final response = MessageResponse.response(payload, state.messages);
      response.map(
        created: (response) => setState(.loaded(messages: response.messages)),
        deleted: (response) => setState(.loaded(messages: response.messages)),
        updated: (response) => setState(.loaded(messages: response.messages)),
        error: (response) => setState(
          .error(messages: state.messages, message: response.message),
        ),
      );
    });
    on<ChatEvent>((event, emit) async {
      await event.map(
        get: (e) => _getMessages(e, emit),
        create: (e) => _createMessage(e, emit),
      );
    });
  }

  final IWebSocket _webSocket;
  final Logger _logger;
  final IMessageRepository _messageRepository;
  final IMessageRealtimeRepository _messageRealTimeRepository;

  StreamSubscription? _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    return super.close();
  }

  Future<void> _getMessages(
    _GetMessagesEvent e,
    Emitter<ChatState> emit,
  ) async {
    try {
      final messages = await _messageRepository.getMessages(chatId: e.chatId);
      emit(.loaded(messages: messages));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(messages: state.messages, message: e));
    }
  }

  Future<void> _createMessage(
    _CreateMessageEvent e,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _messageRealTimeRepository.sendMessage(message: e.message);
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(messages: state.messages, message: e));
    }
  }
}

mixin _SetStateMixin<State extends ChatState> implements Emittable<State> {
  void setState(State state) {
    emit(state);
  }
}
