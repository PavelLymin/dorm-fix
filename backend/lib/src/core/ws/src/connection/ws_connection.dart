import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../rest_api/src/rest_api.dart';

abstract interface class IWsConnection<T> {
  void addConnection({required String uid, required T socket});

  void removeConnection({required String uid, required T socket});

  void sendToUser({required String uid, required Object? message});

  void broadcast({required Object? message});
}

class WsConnection implements IWsConnection<WebSocketChannel> {
  final Map<String, List<WebSocketChannel>> _connections = {};

  @override
  void addConnection({required String uid, required WebSocketChannel socket}) =>
      _connections.putIfAbsent(uid, () => []).add(socket);

  @override
  void removeConnection({
    required String uid,
    required WebSocketChannel socket,
  }) => _connections[uid]?.remove(socket);

  @override
  void sendToUser({required String uid, required Object? message}) {
    final sockets = _connections[uid];

    if (sockets == null) return;

    for (final socket in sockets) {
      socket.sink.add(encode(message));
    }
  }

  @override
  void broadcast({required Object? message}) {
    for (final sockets in _connections.values) {
      for (final socket in sockets) {
        socket.sink.add(encode(message));
      }
    }
  }

  String encode(Object? data) {
    try {
      if (data is String) return data;

      return jsonEncode(data);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        InternalServerException(
          error: {'description': 'Error occurred during encoding'},
        ),
        stackTrace,
      );
    }
  }
}
