import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../chat.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  TypingBloc({required this._typingRepository}) : super(const TypingState()) {
    on<TypingEvent>(
      (event, emit) async =>
          await event.map(typingTextChanged: (e) => _onTextChanged(e, emit)),
      transformer: restartable(),
    );
  }

  final ITypingRealTimeRepository _typingRepository;
  bool _isTyping = false;

  Future<void> _onTextChanged(
    _TypingTextChanged event,
    Emitter<TypingState> emit,
  ) async {
    if (!_isTyping) {
      _isTyping = true;
      await _typingRepository.startTypig(chatId: event.chatId);
    }

    // emit(.startTyping(chatId: _chatId));

    await Future.delayed(const Duration(seconds: 3));

    if (_isTyping) {
      await _typingRepository.stopTypig(chatId: event.chatId);
      // emit(.stopTyping(chatId: _chatId));
    }
  }
}
