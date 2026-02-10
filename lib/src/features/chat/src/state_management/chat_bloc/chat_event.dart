part of 'chat_bloc.dart';

typedef ChatEventMatch<R, E extends ChatEvent> = FutureOr<R> Function(E event);

sealed class ChatEvent {
  const ChatEvent();

  factory ChatEvent.get({required int chatId}) = _GetMessagesEvent;

  factory ChatEvent.create({required PartialMessage message}) =>
      _CreateMessageEvent(message: message);

  FutureOr<R> map<R>({
    required ChatEventMatch<R, _GetMessagesEvent> get,
    required ChatEventMatch<R, _CreateMessageEvent> create,
  }) => switch (this) {
    _GetMessagesEvent e => get(e),
    _CreateMessageEvent e => create(e),
  };
}

final class _GetMessagesEvent extends ChatEvent {
  const _GetMessagesEvent({required this.chatId});

  final int chatId;
}

final class _CreateMessageEvent extends ChatEvent {
  const _CreateMessageEvent({required this.message});

  final PartialMessage message;
}
