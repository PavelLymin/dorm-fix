import 'dart:async';

import 'package:dorm_fix/src/core/ws/ws.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'remote_typing_event.dart';
part 'remote_typing_state.dart';

class RemoteTypingBloc extends Bloc<RemoteTypingEvent, RemoteTypingState>
    with _SetStateMixin {
  RemoteTypingBloc({required IWebSocket webSocket})
    : _webSocket = webSocket,
      super(const .stopTyping()) {
    _subscription = _webSocket.stream.listen((message) {
      if (message.type == .typing) {
        final typingPayload = message.payload as TypingPayload;
        if (typingPayload.isStarted) {
          setState(const .startTyping());
        } else {
          setState(const .stopTyping());
        }
      }
    });
  }

  final IWebSocket _webSocket;
  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }
}

mixin _SetStateMixin<State extends RemoteTypingState>
    implements Emittable<State> {
  void setState(State state) {
    emit(state);
  }
}
