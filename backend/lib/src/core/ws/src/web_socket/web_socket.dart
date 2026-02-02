import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import '../../ws.dart';

abstract interface class IWebSocket<T> {
  void addConnection({required String uid, required T socket});

  void removeConnection({required String uid, required T socket});

  void send(WebSocketChannel socket, String type, Map<String, Object?> payload);

  void sendToUser(
    String type,
    Map<String, Object?> payload, {
    required String uid,
  });

  Future<MessageEnvelope> decodeRaw(Object? raw);
}

class WebSocketBase implements IWebSocket<WebSocketChannel> {
  final Map<String, List<WebSocketChannel>> _connections = {};
  Map<String, List<WebSocketChannel>> get connections => _connections;

  @override
  void addConnection({required String uid, required WebSocketChannel socket}) =>
      _connections.putIfAbsent(uid, () => []).add(socket);

  @override
  void removeConnection({
    required String uid,
    required WebSocketChannel socket,
  }) => _connections[uid]?.remove(socket);

  @override
  void sendToUser(
    String type,
    Map<String, Object?> payload, {
    required String uid,
  }) {
    final sockets = _connections[uid];

    if (sockets == null) return;

    for (final socket in sockets) {
      send(socket, type, payload);
    }
  }

  @override
  void send(
    WebSocketChannel socket,
    String type,
    Map<String, Object?> payload,
  ) {
    final envelope = MessageEnvelope(type: type, payload: payload);
    final json = jsonEncode(envelope.toJson());
    socket.sink.add(json);
  }

  @override
  Future<MessageEnvelope> decodeRaw(Object? raw) async {
    if (raw == null) throw Exception('Received null from socket');

    if (raw is String) {
      final map = await _decodeString(raw);
      return MessageEnvelope.fromJson(map);
    }

    if (raw is List<int>) {
      final map = await _decodeBytes(raw);
      return MessageEnvelope.fromJson(map);
    }

    if (raw is Map<String, Object?>) {
      return MessageEnvelope.fromJson(raw);
    }

    throw Exception('Unsupported message type: \${raw.runtimeType}');
  }

  Future<Map<String, Object?>> _decodeString(String stringBody) async {
    if (stringBody.isEmpty) return <String, Object?>{};

    return _parseJsonString(stringBody);
  }

  Future<Map<String, Object?>> _decodeBytes(List<int> bytesBody) async {
    if (bytesBody.isEmpty) return <String, Object?>{};

    return _parseJsonBytes(bytesBody)!;
  }
}

final _jsonUTF8 = json.fuse(utf8);

Map<String, Object?> _parseJsonString(String s) =>
    jsonDecode(s) as Map<String, Object?>;

Map<String, Object?>? _parseJsonBytes(List<int> bytes) =>
    _jsonUTF8.decode(bytes) as Map<String, Object?>?;
