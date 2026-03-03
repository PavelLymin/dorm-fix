part of 'typing_bloc.dart';

typedef TypingEventMatch<R, E extends TypingEvent> = R Function(E event);

sealed class TypingEvent {
  const TypingEvent({required this.chatId});

  final int chatId;

  const factory TypingEvent.textChanged({
    required int chatId,
    required String text,
  }) = _TypingTextChanged;

  R map<R>({
    required TypingEventMatch<R, _TypingTextChanged> typingTextChanged,
  }) => switch (this) {
    _TypingTextChanged e => typingTextChanged(e),
  };
}

class _TypingTextChanged extends TypingEvent {
  const _TypingTextChanged({required super.chatId, required this.text});

  final String text;
}
