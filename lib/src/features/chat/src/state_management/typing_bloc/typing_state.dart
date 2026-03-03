part of 'typing_bloc.dart';

typedef TypingStateMatch<R, S extends TypingState> = R Function(S state);

class TypingState {
  const TypingState();
  // const TypingState({required this.chatId, required this.isTyping});

  // const factory TypingState.startTyping({required int chatId}) = _StartTyping;

  // const factory TypingState.stopTyping({required int chatId}) = _StopTyping;

  // const factory TypingState.error({
  //   required int chatId,
  //   required String error,
  // }) = _Error;

  // final int chatId;
  // final bool isTyping;

  // R map<R>({
  //   required TypingStateMatch<R, _StartTyping> startTyping,
  //   required TypingStateMatch<R, _StopTyping> stopTyping,
  //   required TypingStateMatch<R, _Error> error,
  // }) => switch (this) {
  //   _StartTyping e => startTyping(e),
  //   _StopTyping e => stopTyping(e),
  //   _Error e => error(e),
  // };

  // R maybeMap<R>({
  //   required R Function() orElse,
  //   TypingStateMatch<R, _StartTyping>? startTyping,
  //   TypingStateMatch<R, _StopTyping>? stopTyping,
  //   TypingStateMatch<R, _Error>? error,
  // }) => map<R>(
  //   startTyping: startTyping ?? (_) => orElse(),
  //   stopTyping: stopTyping ?? (_) => orElse(),
  //   error: error ?? (_) => orElse(),
  // );

  // R? mapOrNull<R>({
  //   TypingStateMatch<R, _StartTyping>? startTyping,
  //   TypingStateMatch<R, _StopTyping>? stopTyping,
  //   TypingStateMatch<R, _Error>? error,
  // }) => map<R?>(
  //   startTyping: startTyping ?? (_) => null,
  //   stopTyping: stopTyping ?? (_) => null,
  //   error: error ?? (_) => null,
  // );
}

// final class _StartTyping extends TypingState {
//   const _StartTyping({required super.chatId, super.isTyping = true});
// }

// final class _StopTyping extends TypingState {
//   const _StopTyping({required super.chatId, super.isTyping = false});
// }

// final class _Error extends TypingState {
//   const _Error({
//     required super.chatId,
//     super.isTyping = false,
//     required this.error,
//   });

//   final String error;
// }
