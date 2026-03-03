part of 'remote_typing_bloc.dart';

typedef RemoteTypingStateMatch<R, S extends RemoteTypingState> =
    R Function(S state);

sealed class RemoteTypingState {
  const RemoteTypingState({required this.isTyping});

  const factory RemoteTypingState.startTyping() = _StartTyping;

  const factory RemoteTypingState.stopTyping() = _StopTyping;

  final bool isTyping;

  R map<R>({
    required RemoteTypingStateMatch<R, _StartTyping> startTyping,
    required RemoteTypingStateMatch<R, _StopTyping> stopTyping,
  }) => switch (this) {
    _StartTyping e => startTyping(e),
    _StopTyping e => stopTyping(e),
  };

  R maybeMap<R>({
    required R Function() orElse,
    RemoteTypingStateMatch<R, _StartTyping>? startTyping,
    RemoteTypingStateMatch<R, _StopTyping>? stopTyping,
  }) => map<R>(
    startTyping: startTyping ?? (_) => orElse(),
    stopTyping: stopTyping ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    RemoteTypingStateMatch<R, _StartTyping>? startTyping,
    RemoteTypingStateMatch<R, _StopTyping>? stopTyping,
  }) => map<R?>(
    startTyping: startTyping ?? (_) => null,
    stopTyping: stopTyping ?? (_) => null,
  );
}

final class _StartTyping extends RemoteTypingState {
  const _StartTyping({super.isTyping = true});
}

final class _StopTyping extends RemoteTypingState {
  const _StopTyping({super.isTyping = false});
}
