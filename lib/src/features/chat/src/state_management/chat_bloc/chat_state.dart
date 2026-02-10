part of 'chat_bloc.dart';

typedef ChatStateMatch<R, S extends ChatState> = R Function(S state);

sealed class ChatState {
  const ChatState({required this.messages});

  final List<FullMessage> messages;

  const factory ChatState.loading({required List<FullMessage> messages}) =
      _ChatLoading;

  const factory ChatState.loaded({required List<FullMessage> messages}) =
      _ChatLoaded;

  const factory ChatState.error({
    required List<FullMessage> messages,
    required Object message,
  }) = _ChatError;

  R map<R>({
    required ChatStateMatch<R, _ChatLoading> loading,
    required ChatStateMatch<R, _ChatLoaded> loaded,
    required ChatStateMatch<R, _ChatError> error,
  }) => switch (this) {
    _ChatLoading s => loading(s),
    _ChatLoaded s => loaded(s),
    _ChatError s => error(s),
  };

  R maybeMap<R>({
    ChatStateMatch<R, _ChatLoading>? loading,
    ChatStateMatch<R, _ChatLoaded>? loaded,
    ChatStateMatch<R, _ChatError>? error,
    required R Function() orElse,
  }) => map<R>(
    loading: loading ?? (_) => orElse(),
    loaded: loaded ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    ChatStateMatch<R, _ChatLoading>? loading,
    ChatStateMatch<R, _ChatLoaded>? loaded,
    ChatStateMatch<R, _ChatError>? error,
  }) => map<R?>(
    loading: loading ?? (_) => null,
    loaded: loaded ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _ChatLoading extends ChatState {
  const _ChatLoading({required super.messages});
}

final class _ChatLoaded extends ChatState {
  const _ChatLoaded({required super.messages});
}

final class _ChatError extends ChatState {
  const _ChatError({required super.messages, required this.message});

  final Object message;
}
